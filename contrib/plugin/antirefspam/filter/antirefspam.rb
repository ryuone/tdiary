#
# antirefspamfilter.rb
#
# Copyright (c) 2004 T.Shimomura <redbug@netlife.gr.jp>
#

=begin

ver 0.9 2004/11/24
	��󥯸��ִ��ꥹ�Ȥ˥ޥå������󥯸����ꤹ�뵡ǽ���ɲ� (thanks to Shun-ichi TAHARA)
	�����Ȥ����¤�����ɽ����Ȥ���褦�ˤ���
	HTTP.version_1_2 �Ϥ�Ȥ��ʤ��ä�����ư����������ä��Զ�����
	spamips �˽��Ϥ��������ʬ/����ʬ�����������ä��Τ���
	����¾���顼�������ˤ����褦�˽������ѹ�

ver 0.8 2004/11/15
	�ץ����������С�����ꤹ�뵡ǽ���ɲ�
	ver 0.6m��0.71 �ǡ�Ruby 1.6 �Ϥǥ��顼���Ф뤳�Ȥ����ä��Զ�����

ver 0.71 2004/11/12
	ver 0.6m �� ver 0.7 �ǡ�"���ꤹ���󥯸�" �λ��꤬Ŭ�Ѥ���ʤ��ʤäƤ����Զ�����

ver 0.7 2004/11/11
	�����Υ���ƥʤǡ�����ˤ�äƹ������������ʤ����Ȥ����ä�������н�
	�����ȥ��ѥ���н褹�뤿�ᡢ�����Ȥ����¤򤫤��뵡ǽ���ɲ�

ver 0.6m 2004/11/07
	�������Υ���ǥ���ѹ�
	if not��unless�ؤν񤭴�����

ver 0.6 2004/11/07
	�ȥåץڡ���URL�ʳ��ε��Ƥ�����������Ǥ���褦�ˤ�����
	������̤θ���꥽������ʬ�䤷����

ver 0.5 2004/10/31
	����Ǥ���URL ������ɽ����Ȥ���褦�ˤ���
	safeurls, spaurls �ˡ�Ʊ��� URL ������Ϣ³�ǵ�Ͽ�����������н褷��(�Ĥ��)

ver 0.4 2004/10/20
	Ruby 1.8.2 (preview2) ��ư��ʤ��ä��Զ�����
	��³����ݡ��Ȥ�80����uri.port���ѹ� (thanks to MoonWolf)

ver 0.3 2004/09/30
	��٤򲼤��뤿��ν��������äȤ������줿

ver 0.2 2004/09/27
	����Ǥ���URL�ΰ�����������̤����ѹ��Ǥ���褦�ˤ���

ver 0.1 2004/09/15
	�ǽ�ΥС������

=end

require 'net/http'
require 'uri'

module TDiary
  module Filter

    class AntirefspamFilter < Filter
      def debug_out(filename, str)
        if $debug
          filename = File.join(@conf.data_path,"AntiRefSpamFilter",filename)
          File::open(filename, "a+") {|f|
            f.puts str
          }
        end
      end

      # str �˻��ꤵ�줿ʸ����Ŭ�ڤʥ�����ޤ�Ǥ��뤫������å�
      def check(str)
        # str �˥ȥåץڡ���URL���ޤޤ�Ƥ��뤫�ɤ���
        unless @conf.index_page.empty?
          if str.include? @conf.index_page
            return true
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
        # ��󥯸���̵��
        unless referer
          return true
        end
        # �����Υ���ƥʤǹ������郎���ʤ��ʤ�������б����뤿�ᡢ��󥯸�����ʸ������ξ��ϵ��Ƥ���
        if referer.size <= 1
          return true
        end

        @work_path = File.join(@conf.data_path,"AntiRefSpamFilter")
        @spamurl_list = File.join(@work_path,"spamurls")  # referer spam �Υ�󥯸�����
        @spamip_list  = File.join(@work_path,"spamips")   # referer spam ��IP����
        @safeurl_list = File.join(@work_path,"safeurls")  # �����餯������Τʤ���󥯸�����

        # ��ʬ�������⤫��Υ�󥯤Ͽ��ꤹ��
        if check(referer)
          return true
        end

        # ����Ǥ���URL �˹��פ��뤫
        if trustedurls=@conf['antirefspam.trustedurl']
          trustedurls.to_s.each_line do |trusted|
            trusted.sub!(/\r?\n/,'')
            next if trusted=~/\A(\#|\s*)\z/
            
            # �ޤ��� "����Ǥ��� URL" �� referer �˴ޤޤ�뤫�ɤ���
            if referer.include? trusted
              debug_out("trusted1", trusted+" --- "+referer)
              return true
            end
            
            # �ޤޤ�ʤ��ä����� "����Ǥ��� URL" ������ɽ���Ȥߤʤ��ƺƥ����å�
            begin
              url = trusted.gsub("/", "\\/").gsub(":", "\\:")
              exp = Regexp.new(url)
              
              if referer =~ exp
                debug_out("trusted2", trusted+" --- "+referer)
                return true
              end
            rescue
              debug_out("error_config", trusted)
            end
          end
        end

        # URL�ִ��ꥹ�Ȥ򸫤�
        if @conf['antirefspam.checkreftable'] != nil
          if @conf['antirefspam.checkreftable'].to_s == 'true'
            @conf.referer_table.each do |url, name|
              begin
                if /#{url}/i =~ referer
                  debug_out("trusted3", url+" --- "+referer)
                  return true
                end
              rescue
                debug_out("error_config", url)
              end
            end
          end
        end

        # ������
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
        # �����å����ˤ��оݤΥɥᥤ��̾����ä�����ե��������
        begin
          File::open(File.join(@work_path,uri.host), File::RDONLY | File::CREAT | File::EXCL).close

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
          proxy_server = nil
          proxy_port = nil
          unless @conf['antirefspam.proxy_server'].empty?
            proxy_server = @conf['antirefspam.proxy_server']
            proxy_port = @conf['antirefspam.proxy_port']
          end
          body = ""
          begin
            Net::HTTP::Proxy(proxy_server, proxy_port).start(uri.host, uri.port) do |http|
              if uri.path == ""
                response, = http.get("/")
              else
                response, = http.get(uri.request_uri)
              end
              body = response.body
            end

            # body �������� URL ���ޤޤ�Ƥ��ʤ���� SPAM �Ȥߤʤ�
            unless check(body)
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
            File::delete(File.join(@work_path,uri.host))
          rescue
          end
        end

        return true
      end

      def comment_filter( diary, comment )
        # �ĥå��ߤ����ܸ�(�Ҥ餬��/��������)���ޤޤ�Ƥ��ʤ�����Ե���
        if @conf['antirefspam.comment_kanaonly'] != nil
          if @conf['antirefspam.comment_kanaonly'].to_s == 'true'
            unless comment.body =~ /[��-��-����]/
              return false
            end
          end
        end

        # �ĥå��ߤ�ʸ���������ꤷ����°���Ǥʤ��ʤ��Ե���
        maxsize = @conf['antirefspam.comment_maxsize'].to_i
        if maxsize > 0
          unless comment.body.size <= maxsize
            return false
          end
        end

        # NG��ɤ����ĤǤ�ޤޤ�Ƥ������Ե���
        if @conf['antirefspam.comment_ngwords'] != nil
          ngwords = @conf['antirefspam.comment_ngwords']
          ngwords.to_s.each_line do |ngword|
            ngword.sub!(/\r?\n/,'')
            if comment.body.downcase.include? ngword.downcase
              return false
            end

            # �ޤޤ�ʤ��ä����� "NG���" ������ɽ���Ȥߤʤ��ƺƥ����å�
            begin
              if comment.body =~ Regexp.new( ngword, Regexp::MULTILINE )
                return false
              end
            rescue
              debug_out("error_config2", ngword)
            end
          end
        end

        return true
      end
    end
  end
end
