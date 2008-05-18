# tdiarytimes.rb $Revision: 1.2 $
#
# Copyright (c) 2003 neuichi <neuichi@nmnl.jp>
# Distributed under the GPL
#
# �ץ饰�������ۥڡ���
# http://nmnl.jp/hiki/software/?tDiary+%3A%3A+Plugin
#
# ư����:
# ruby-gd���Ȥ���Ķ���ɬ�פǤ���
#
# �Ȥ���:
# ���Υץ饰�����ץ饰����ǥ��쥯�ȥ�����졢
# index.rb��Ʊ���ǥ��쥯�ȥ�ˡ�tdiarytimes.png�Ȥ���̾����
# �����Ф��񤭹��߸��¤���äƤ���ե��������ޤ���
#	����������˽񤭹��ߤ��뤴�Ȥˡ�tdiarytimes.png��
#	������񤭹��ߤޤ���
# 
# �����夫�餳��png�ե������ƤӽФ��ˤϡ�
# tDiray�夫��ץ饰����Ȥ���
# <%=tdiarytimes%>
# �Ȥ��ƸƤӽФ��ޤ���
# �����Ȥ���img������alt��ʸ�������ꤹ�뤳�Ȥ����ޤ���
# <%=tdiarytimes 'ʸ����'%>
#
# �ޤ���tdiary.conf�˰ʲ��Υ��ץ�����񤭹��ळ�Ȥˤ�ꡢ
# �������ޥ����򤹤뤳�Ȥ�����ޤ���
# 
# @options['tdiarytimes.width'] = 400
# �ͳѤβ������ǥե������400��
# �ºݤ˽��Ϥ��������������ϡ������+10������������
# 
# @options['tdiarytimes.height'] = 20
# �ͳѤν������ǥե������20��
# �ºݤ˽��Ϥ��������������ϡ������+16������������
# 
# @options['tdiarytimes.file'] = 'tdiarytimes.png'
# ���Ϥ�������ե�����̾���ǥե���Ȥ�'tdiarytimes.png'
# 
# @options['tdiarytimes.fillcolor'] = '#444444'
# �ͳѤο����ǥե���Ȥ�'#444444'
# 
# @options['tdiarytimes.linecolor'] = '#ffffff'
# �����ο����ǥե���Ȥ�'#ffffff'
# 
# @options['tdiarytimes.textcolor'] = '#444444'
# ʸ�������ǥե���Ȥ�'#444444'
# 
# @options['tdiarytimes.text'] = 'T D I A R Y T I M E S'
# ���Ϥ���ʸ�����ǥե���Ȥ�'T D I A R Y T I M E S'���ʤ�Ⱦ�ѱѿ����Τ��б���
# 
# @options['tdiarytimes.day'] = 30
# ������¸��������������ǥե���Ȥ�30��
# ���ξ�硢30���ʾ�Фä��ǡ����Ͼõ�졢�����Ȥ������褵��ʤ��ʤ롣
#

require 'GD'

if /^(append|replace)$/ =~ @mode then

	#�������
	width = @options['tdiarytimes.width'] || 400
	height = @options['tdiarytimes.height'] || 20
	file = @options['tdiarytimes.file'] || 'tdiarytimes.png'
	fillcolor = @options['tdiarytimes.fillcolor'] || '#444444'
	linecolor = @options['tdiarytimes.linecolor'] || '#ffffff'
	textcolor = @options['tdiarytimes.textcolor'] || '#444444'
	text = @options['tdiarytimes.text'] || 'T D I A R Y T I M E S'
	day = @options['tdiarytimes.day'] || 30 
	
	cache = "#{@cache_path}/tdiarytimes"
	Dir::mkdir( cache ) unless File::directory?( cache )

	image = GD::Image.new(width + 10,height + 16)
	transcolor = image.colorAllocate("#fffffe")
	image.transparent(transcolor)
	image.interlace = TRUE
	fillcolor = image.colorAllocate(fillcolor)
	linecolor = image.colorAllocate(linecolor)
	textcolor = image.colorAllocate(textcolor)
	
	#�Ӥ�����
	image.filledRectangle(5,8,width + 4,height + 7,fillcolor)

	#��������
	if width >= 160
		hour = 2
		hour_w = width / 12.0
		image.string(GD::Font::TinyFont, 2, height + 8, "0", textcolor)
		11.times {
			image.string(GD::Font::TinyFont, (hour_w * hour/2).to_i , height + 8, hour.to_s, textcolor)
			hour += 2
		}
		image.string(GD::Font::TinyFont, width + 2, height + 8, "0", textcolor)
	else
		hour = 0
		hour_w = width / 6.0
		6.times {
			image.string(GD::Font::TinyFont, (hour_w * hour/4).to_i + 4, height + 8, hour.to_s, textcolor)
			hour += 4
		}
		image.string(GD::Font::TinyFont, width + 2, height + 8, "0", textcolor)
	end

	#���߻������¸,�ɤ߹���
	begin
		io = open("#{cache}/tdiarytimes.dat","r")
	    ary_times =  Marshal.load(io)
	  io.close
	rescue
		ary_times = []
	end

	ary_times << Time.now.to_f
	ary_times_new = []

	while ary_times.size != 0
		time = ary_times.shift
		time_now = Time.now.to_f.to_i
		ary_times_new << time.to_i if (86400 * day) > (time_now - time).to_i
	end

	ary_times = ary_times_new

	io = open("#{cache}/tdiarytimes.dat","w")
	  Marshal.dump(ary_times,io)
	io.close


	#���ּ�������
	while ary_times.size != 0
		time = Time.at(ary_times.shift)
		time_w = ((time.to_a[2] * 60 + time.to_a[1]) / 1440.0 * width).to_i
		image.line(time_w + 5, 8 ,time_w + 5,height + 7, linecolor)
	end

	#ʸ��������
	image.string(GD::Font::TinyFont, 5, 0, text, textcolor)

	pngfile = open(file, 'w')
		image.png(pngfile)
	pngfile.close
	
end

def tdiarytimes(alt = nil)
	width = @options['tdiarytimes.width'].to_i || 400
	width += 10
	
	height = @options['tdiarytimes.height'].to_i || 20
	height += 16
	
	file = @options['tdiarytimes.file'] || 'tdiarytimes.png'
	text = @options['tdiarytimes.text'] || 'T D I A R Y T I M E S'

	result = ""
	
	if alt
		result << %Q|<img src="#{h file}" alt="#{h alt}" width="#{width}" height="#{height}" class="tdiarytimes">|
	else
		result << %Q|<img src="#{h file}" alt="#{h text}" width="#{width}" height="#{height}" class="tdiarytimes">|
	end

	result

end
