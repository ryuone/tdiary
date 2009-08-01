#
# antirefspamfilter.rb
#
# Copyright (c) 2004-2005 T.Shimomura <redbug@netlife.gr.jp>
# You can redistribute it and/or modify it under GPL2.
# Please use version 1.0.0 (not 1.0.0G) if GPL doesn't want to be forced on me.
#

require 'net/http'
require 'uri'

module TDiary
  module Filter

    class AntirefspamFilter < Filter
      # ͭ���ˤ���Ȼ��ꤷ���ե�����˥ǥХå�����ʸ������ɵ�����
      def debug_out(filename, str)
        if $debug
          filename = File.join(@conf.data_path,"AntiRefSpamFilter",filename)
          File::open(filename, "a+") {|f|
            f.puts str
          }
        end
      end

      # str �˻��ꤵ�줿ʸ����Ŭ�ڤʥ�����ޤ�Ǥ��뤫������å�
      def isIncludeMyUrl(str)
        # str ��������URL���ޤޤ�Ƥ��뤫�ɤ���
        base_url = @conf.base_url
        unless base_url.empty?
          if str.include? base_url
            return true
          end
        end

        # str �˥ȥåץڡ���URL���ޤޤ�Ƥ��뤫�ɤ���
        unless @conf.index_page.empty?
          if /\Ahttps?:\/\// =~ @conf.index_page
            if str.include? @conf.index_page
              return true
            end
          end
        end

        # str �˵��Ƥ������褬�ޤޤ�Ƥ��뤫�ɤ���
        if (myurl = @conf['antirefspam.myurl']) && !myurl.empty?
          if str.include? myurl
            return true
          end
          
          url = myurl.gsub("/", "\\/").gsub(":", "\\:")
          exp = Regexp.new(url)
          if exp =~ str
            return true
          end
        end

        return false
      end

      def referer_filter(referer)
        conf_disable = @conf['antirefspam.disable'] != nil ? @conf['antirefspam.disable'].to_s : ''
        conf_checkreftable = @conf['antirefspam.checkreftable'] != nil ? @conf['antirefspam.checkreftable'].to_s : ''
        conf_trustedurl = @conf['antirefspam.trustedurl'] != nil ? @conf['antirefspam.trustedurl'].to_s : ''
        conf_proxy_server = @conf['antirefspam.proxy_server'] != nil && @conf['antirefspam.proxy_server'].size > 0 ? @conf['antirefspam.proxy_server'].to_s : nil
        conf_proxy_port = @conf['antirefspam.proxy_port'] != nil && @conf['antirefspam.proxy_port'].size > 0 ? @conf['antirefspam.proxy_port'].to_s : nil

        if conf_disable == 'true'  or    # ��󥯸������å���ͭ���ǤϤʤ����ϥ��롼����
           referer == nil          or    # ��󥯸���̵��
           referer.size <= 1       or    # �����Υ���ƥʤǹ������郎���ʤ��ʤ�������б����뤿�ᡢ��󥯸�����ʸ������ξ��ϵ���
           isIncludeMyUrl(referer)       # ��ʬ�������⤫��Υ�󥯤Ͽ��ꤹ��
        then
          return true
        end

        # "����Ǥ���URL" �򣱤Ĥ��ļ��Ф���referer�ȹ��פ��뤫�����å�����
        conf_trustedurl.each_line do |trusted|
          trusted.sub!(/\r?\n/,'')
          next if trusted =~ /\A(\#|\s*)\z/  # #�ޤ��϶���ǻϤޤ�Ԥ��ɤ����Ф�
          
          # �ޤ��� "����Ǥ��� URL" �� referer �˴ޤޤ�뤫�ɤ���
          if referer.include? trusted
            debug_out("trusted", trusted+" (include?) "+referer)
            return true
          end
          
          # �ޤޤ�ʤ��ä����� "����Ǥ��� URL" ������ɽ���Ȥߤʤ��ƺƥ����å�
          begin
            if referer =~ Regexp.new( trusted.gsub("/", "\\/").gsub(":", "\\:") )
              debug_out("trusted", trusted+" (=~) "+referer)
              return true
            end
          rescue
            debug_out("error_config", "trustedurl: "+trusted)
          end
        end

        # URL�ִ��ꥹ�Ȥ򸫤�
        if conf_checkreftable == 'true'
          # "URL�ִ��ꥹ��" �򣱤Ĥ��ļ��Ф���referer�ȹ��פ��뤫�����å�����
          @conf.referer_table.each do |url, name|
            begin
              if /#{url}/i =~ referer && url != '^(.{50}).*$'
                debug_out("trusted", url+" (=~referer_table)  "+referer)
                return true
              end
            rescue
              debug_out("error_config", "referer_table: "+url)
            end
          end
        end

        @work_path = File.join(@conf.data_path,"AntiRefSpamFilter")
        @spamurl_list = File.join(@work_path,"spamurls")  # referer spam �Υ�󥯸�����
        @spamip_list  = File.join(@work_path,"spamips")   # referer spam ��IP����
        @safeurl_list = File.join(@work_path,"safeurls")  # �����餯������Τʤ���󥯸�����

        # �ǥ��쥯�ȥ�/�ե����뤬¸�ߤ��ʤ���к��
        unless File.exist? @work_path
          Dir::mkdir(@work_path)
        end
        unless File.exist? @spamurl_list
          File::open(@spamurl_list, "a").close
        end
        unless File.exist? @safeurl_list
          File::open(@safeurl_list, "a").close
        end

        uri = URI.parse(referer)
        temp_filename = File.join(@work_path,uri.host)
        # �����å����ˤ��оݤΥɥᥤ��̾����ä�����ե��������
        begin
          File::open(temp_filename, File::RDONLY | File::CREAT | File::EXCL).close

          # ���� SPAM URL �Ȥߤʤ�����ʸ�ϰʸ�ϵ���
          spamurls = IO::readlines(@spamurl_list).map {|url| url.chomp }
          if spamurls.include? referer
            return false
          end

          # ���� SPAM URL �Ǥʤ���Ƚ�Ǥ�����ʸ�ϵ���
          safeurls = IO::readlines(@safeurl_list).map {|url| url.chomp }
          if safeurls.include? referer
            return true
          end

          # ��󥯸� URL �� HTML �����ĥ�äƤ���
          Net::HTTP.version_1_2   # ���ޤ��ʤ��餷��
          body = ""
          begin
            Net::HTTP::Proxy(conf_proxy_server, conf_proxy_port).start(uri.host, uri.port) do |http|
              if uri.path == ""
                response, = http.get("/")
              else
                response, = http.get(uri.request_uri)
              end
              body = response.body
            end

            # body �������� URL ���ޤޤ�Ƥ��ʤ���� SPAM �Ȥߤʤ�
            unless isIncludeMyUrl(body)
              File::open(@spamurl_list, "a+") {|f|
                f.puts referer
              }
              File::open(@spamip_list, "a+") {|f|
                f.puts [@cgi.remote_addr, Time.now.utc.strftime("%Y/%m/%d %H:%M:%S UTC")].join("\t")
              }
              return false
            else
              File::open(@safeurl_list, "a+") {|f|
                f.puts referer
              }
            end
          rescue
            # ���顼���Ф����� @spamurl_list ������ʤ�����󥯸��ˤ�����ʤ�
            return false
          end

        rescue StandardError, TimeoutError
          # ���ߥ����å���ʤ顢����ϥ�󥯸��˴��ꤷ�ʤ�
          return false
        ensure
          begin
            File::delete(temp_filename)
          rescue
          end
        end

        return true
      end



      def log_spamcomment( diary, comment )
        @work_path = File.join(@conf.data_path,"AntiRefSpamFilter")
        @spamcomment_list = File.join(@work_path,"spamcomments")  # comment spam �ΰ���

        # �ǥ��쥯�ȥ�/�ե����뤬¸�ߤ��ʤ���к��
        unless File.exist? @work_path
          Dir::mkdir(@work_path)
        end
        unless File.exist? @spamcomment_list
          File::open(@spamcomment_list, "a").close
        end

        File::open(@spamcomment_list, "a+") {|f|
          f.puts "From: "+comment.name+" <"+comment.mail+">"
          f.puts "To: "+diary.date.to_s
          f.puts "Date: "+comment.date.to_s
          f.puts comment.body
          f.puts ".\n\n"
        }
      end

      def comment_filter( diary, comment )
        # �ĥå��ߤ����ܸ�(�Ҥ餬��/��������)���ޤޤ�Ƥ��ʤ�����Ե���
        if @conf['antirefspam.comment_kanaonly'] != nil
          if @conf['antirefspam.comment_kanaonly'].to_s == 'true'
            unless comment.body =~ /[��-��-����]/
              log_spamcomment( diary, comment )
              return false
            end
          end
        end

        # �ĥå��ߤ�ʸ���������ꤷ����°���Ǥʤ��ʤ��Ե���
        maxsize = @conf['antirefspam.comment_maxsize'].to_i
        if maxsize > 0
          unless comment.body.size <= maxsize
            log_spamcomment( comment )
            return false
          end
        end

        # NG��ɤ����ĤǤ�ޤޤ�Ƥ������Ե���
        if @conf['antirefspam.comment_ngwords'] != nil
          ngwords = @conf['antirefspam.comment_ngwords']
          ngwords.to_s.each_line do |ngword|
            ngword.sub!(/\r?\n/,'')
            if comment.body.downcase.include? ngword.downcase
              log_spamcomment( comment )
              return false
            end

            # �ޤޤ�ʤ��ä����� "NG���" ������ɽ���Ȥߤʤ��ƺƥ����å�
            begin
              if comment.body =~ Regexp.new( ngword, Regexp::MULTILINE )
                log_spamcomment( comment )
                return false
              end
            rescue
              debug_out("error_config", "comment_ngwords: "+ngword)
            end
          end
        end

        return true
      end
    end
  end
end
