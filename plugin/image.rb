# image_plugin.rb
# -pv-
# 
# ̾��:
# ������Plugin
#
# ����:
# �����������̤���β������åץ��ɡ���ʸ�ؤ�ɽ��
#
# �Ȥ����:
# ��ʸ
#
# �Ȥ���:
# image(number,'altword') - ������ɽ�����ޤ���
#  number - �������ֹ�0��1��2��
#  altword - img������ alt�������ʸ����
#
# image_left(number,'altword') - image��class=left���ɲä��ޤ���
# image_right(number,'altword') - image��class=right���ɲä��ޤ���
#
# ����¾:
# tDiary version 1.5.3.20030420�ʹߤ�ư��ޤ���
# tdiary.conf�ǡ�
# �����ե��������¸����ǥ��쥯�ȥ�
#  @optons['image.dir']
# �����ե��������¸����ǥ��쥯�ȥ��URL
#  @options['image.url']
# �����ꤷ�Ƥ���������
# �ޤ���@secure = true�ʴĶ��Ǥ�ư��ޤ���
#
# �饤���󥹤ˤĤ���:
# Copyright (c) 2002,2003 Daisuke Kato <dai@kato-agri.com>
# Copyright (c) 2002 Toshi Okada <toshi@neverland.to>
# Copyright (c) 2003 Yoshimi KURUMA <yoshimik@iris.dti.ne.jp>
# Distributed under the GPL

=begin Changelog
2003-4-23 Daisuke Kato <dai@kato-agri.com>
    * tuning around form tag.
    
2003-4-23 Yoshimi KURUMA <yoshimik@iris.dti.ne.jp>
    * Now img tag includes class="photo".
    * New Option. image.maxnum, image.maxsize.
    * fine tuning around form tag.

2003-4-22 Yoshimi KURUMA <yoshimik@iris.dti.ne.jp>
    * version 0.5 first form_proc version.
=end

@image_dir = @options && @options['image.dir'] || './images/'
@image_url = @options && @options['image.url'] || './images/'


add_body_enter_proc do |date|	
   @image_date = date.strftime( "%Y%m%d" )
   ""
end

def image( id, alt = 'image', width = nil, place = 'photo' )
   list=image_list(@image_date)
   %Q[<img class="#{place}" src="#{@image_url}#{list[id]}" alt="#{alt}">]
end

def image_left( id, alt = "image", width = nil)
   image( id, alt, width, "left" )
end

def image_right( id, alt = "image",width = nil)
   image( id, alt, width, "right" )
end

def image_list(date)
   image_path=[]
   Dir.foreach(@image_dir){ |file|
      if file=~ /(.*)\_(.*)\.(.*)/
         if $1==date
            image_path[$2.to_i]=file
         end
      end
   }
   image_path
end

add_form_proc do |date|
   image_maxnum = @options && @options['image.maxnum'] || 10
   image_maxsize = @options && @options['image.maxsize'] || 512000

   if @cgi.params['plugin_image_addimage'][0]
      image_filename = ''
      image_extension = ''
      image_date = date.strftime("%Y%m%d")
      image_filename = @cgi.params['plugin_image_file'][0].original_filename
      if image_filename =~ /(\.jpg|\.jpeg|\.gif|\.png)\z/i
         image_extension = $1
         if image_list(image_date).compact.length < image_maxnum
            image_file = @image_dir + image_date + "_" + image_list(image_date).length.to_s + image_extension
            image_file.untaint
            #if @cgi.params['plugin_image_file'][0].size <= image_maxsize
            File::umask( 022 )
            File::open( image_file, "wb" ) {|f|
               f.puts @cgi.params['plugin_image_file'][0].read
            }
            #end
         end
      end
   elsif @cgi.params['plugin_image_delimage'][0]
      image_date = date.strftime("%Y%m%d")
      
      @cgi.params['plugin_image_id'].each do |id|
         image_file = "#{@image_dir}#{image_list(image_date)[id.to_i]}"
         image_file.untaint
         if File::file?(image_file) && File::exist?(image_file)
            File::delete(image_file)
         end
      end
   end
   
   i=%Q[<form method="post" action="#{@conf.update}">]
   id = 0
   image_list(date.strftime("%Y%m%d")).each do |img|
      i<< %Q[(#{id})<input type="checkbox" name="plugin_image_id" value="#{id}"><img class="form" src="#{@image_url}#{img}">] if img
      id +=1
   end
   
   %Q[<div class="form">
   <form method="post" enctype="multipart/form-data" action="#{@conf.update}">
   <input type="hidden" name="plugin_image_addimage" value="true">
   <input type="hidden" name="date" value="#{date.strftime( '%Y%m%d' )}">
   <input type="file"	name="plugin_image_file">
   <input type="submit" name="plugin" value="�����ե�������ɲ�">
   </form>
   #{i}<br>
   <input type="hidden" name="plugin_image_delimage" value="true">
   <input type="hidden" name="date" value="#{date.strftime( '%Y%m%d' )}">
   <input type="submit" name="plugin" value="���򤷤������ե�����κ��">
   </form></div>]
end

