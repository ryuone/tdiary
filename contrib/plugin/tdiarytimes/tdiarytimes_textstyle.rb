# tdiarytimes_textstyle.rb $Revision: 1.2 $
#
# Copyright (c) 2004 phonondrive <tdiary@phonondrive.com>
# Distributed under the GPL
#
# �ץ饰�������ۥڡ�����
# http://phonondrive.com/trd/
# --------------------------------------------------------------------
#
#
#
# Abstract��
# --------------------------------------------------------------------
# ��������Ͽ���������Ӥ򥿥���饤���˵�Ͽ���ޤ���
# ��Ͽ���줿����ȥ�������ηв�ȶ��˥ե����ɥ����Ȥ��Ƥ����ޤ���
# ���Τ褦�� MTBlogTimes �� tdiarytimes ��Ʊ���ε�ǽ��ƥ����ȤǼ¸����ޤ���
# �ޤ����ƥ����ȥ١����Ǥ��뤳�Ȥ�������������ʥ����ȥǥ����󤬲�ǽ�Ǥ���
# ruby-gd �Υ��󥹥ȡ����Ȥ�ɬ�פʤ����ᡢ�����˻��ѽ���ޤ���
#
#
# Usage��
# --------------------------------------------------------------------
# �ץ饰����ϡ��ץ饰����ե����������Ƥ���������
# �إå������뤤�ϥեå��������Ϥ��� <%= tdiarytimes_textstyle %>
# �ΰ��֤˥�����饤��ʸ����Ÿ������ޤ���
# ����������ȥ�ε�Ͽ���ݻ����֤β᤮���Ť�����ȥ�κ���ϡ�
# �������ɲä������Ͽ���˹Ԥ��ޤ���
# ������������ȥ�Υե����ɥ����ȸ��̤ϥꥢ�륿����˷׻�����ޤ���
# ����ȥ��ɽ��ʬ��ǽ��10ʬ���ȤǤ���
#
#
# Options��
# --------------------------------------------------------------------
#
# ���ߡ�����9�ĤΥ��ץ�����Ѱդ���Ƥ��ޤ���
#
# init_text	��������Ͽ����Ƥ��ʤ������Ӥ�ʸ���� (Ǥ�դ�ʸ����)
# entr_text	��������Ͽ���줿�����Ӥ�ʸ���� (Ǥ�դ�ʸ����)
# init_color	��������Ͽ����Ƥ��ʤ������Ӥ�ʸ����ο� (RRBBGG�����ǻ���)
# entr_color	��������Ͽ���줿�����Ӥ�ʸ����ο� (RRBBGG�����ǻ���)
# fade_color	��������Ͽ���줿�����Ӥ�ʸ����Υե����ɥ�������ο� (RRBBGG�����ǻ���)
# init_css	������饤��ʸ�������Τ�CSS���� (CSS�ν񼰤˽��)
# entr_css	��������Ͽ���줿�����Ӥ�ʸ�����CSS���� (CSS�ν񼰤˽��)
# title_text	���֥������Ⱦ�˥ޥ�����ݥ���Ȥ�������TIPSʸ���� (Ǥ�դ�ʸ����)
# fade_time	���Ȥ�����¸���Ƥ���(�ե����ɥ����Ȥ��פ���)���� (Ǥ�դο���)
# entr_interval	����Υ���ȥ���Ͽ���������ְ���Ͽ�����Ͽ���ʤ� (Ǥ�դο���)
#
# ���ץ�����ͤ�������ˡ�ˤ�3�Ĥ���ˡ�����ꡢ����ͥ���̤ϼ����̤�Ǥ���
# <%= tdiarytimes_textstyle %> �������� �� tdiary.conf������ �� �ǥե������
# 
# entr_interval����������ƤΥ��ץ�����ͤ� <%= %> �ؤΰ�������ˤ���������뤿�ᡢ
# �ڡ����ˤ��Ȥ˰վ����ѹ�����ʤɼ�ͳ�٤ι⤤�����ȥǥ����󤬲�ǽ�Ǥ���
# �����ǡ����ƤΥ��ץ����˥ǥե�����ͤ��Ѱդ���Ƥ��뤿�ᡢ
# ���������Ԥ�ʤ��Ƥ�ư��ޤ���
# �ǥե�����ͤζ���Ū���ͤˤĤ��Ƥϡ�tdiary.conf�ؤε�����ˡ�ι�򻲾Ȥ��Ʋ�������
#
#
# <%= tdiarytimes_textstyle %>�ؤΰ�������ˤ�륪�ץ����������ˡ
# --------------------------------------------------------------------
#�ڽ񼰡�
# <%= tdiarytimes_textstyle init_text, entr_text, init_color, entr_color, fade_color, init_css, entr_css, title_text, fade_time %>
#
#�ڵ������ 
# <%=tdiarytimes_textstyle "��","��","004400","66ff66","004400","background-color:#002200;font-size:9px",nil,"TEXTSTYLE!!",15 %>
#
# �� tdiary.conf�����͡��ޤ��ϥǥե�����ͤ���Ѥ��������ϡ������� nil ����ꤷ�Ƥ���������
#
#
# tdiary.conf�ؤε��Ҥˤ�륪�ץ����������ˡ
# --------------------------------------------------------------------
#�ڵ������ (��Ȥ��ƻ��ꤵ��Ƥ����ͤϡ��ץ饰�������Τλ��ĥǥե�����ͤǤ�)
# @options['tdiarytimes_textstyle.init_text'] = "|"
# @options['tdiarytimes_textstyle.entr_text'] = "|"
# @options['tdiarytimes_textstyle.init_color'] = "444444"
# @options['tdiarytimes_textstyle.entr_color'] = "eeeeee"
# @options['tdiarytimes_textstyle.fade_color'] = "444444"
# @options['tdiarytimes_textstyle.init_css'] = "background-color:#444444;"
# @options['tdiarytimes_textstyle.entr_css'] = ""
# @options['tdiarytimes_textstyle.title_text'] = "TDIARYTIMES-TEXTSTYLE"
# @options['tdiarytimes_textstyle.fade_time'] = 30
# @options['tdiarytimes_textstyle.entr_interval'] = 1
#
# �� fade_time ��ñ�̤�����entr_interval ��ñ�̤ϻ��֤Ǥ���
# �� ���Ȥ�����¸���Ƥ�������(�ե����ɥ����ȴ���)��᤮���ǡ�������ȥ�ϡ�
# ������ַв��μ��������ɲû��˥��ե����뤫��������ޤ���
# ���δ��֤���ꤹ�� fade_time �ͤϡ�<%= %> ��������ϻ������ޤ���
# �ǥե������(30��)�ʳ����ͤ��Ѥ��������ϡ�ɬ�� tdiary.conf �ˤƻ��ꤷ�Ʋ�������
# Ʊ�ͤˡ�entr_interval ��ǥե������(1����)�ʳ������ꤷ�������ϡ�
# tdiary.conf �ˤƻ��ꤷ�Ʋ����������ʤߤ�0.5����30ʬ�ֳ֤ˤʤ�ޤ���
#
#
# In secure mode��
# --------------------------------------------------------------------
# ���ߤΤȤ���ư��ޤ���(���ե�������ɤ߹���ʤ���)
#
#
# Acknowledgements��
# --------------------------------------------------------------------
# This plugin is based on tdiarytimes.rb $Revision: 1.2 $
# Copyright (c) 2003 neuichi <neuichi@nmnl.jp>
# Distributed under the GPL
# http://nmnl.jp/hiki/software/?tDiary+%3A%3A+Plugin
#
#
=begin ChangeLog
2004.03.04 phonondrive  <tdiary@phonondrive.com>
   * version 1.0.4
	�����USER-AGENT�ꥹ�Ȥ򹹿����ޤ�����

2004.02.05 phonondrive  <tdiary@phonondrive.com>
   * version 1.0.3
	�ե����ɥ����ȸ��̤η׻���̤����������Ϥ���ʤ����������ޤ�����

2004.01.30 phonondrive  <tdiary@phonondrive.com>
   * version 1.0.2
	������Ͽ�ֳ֤Υ��ץ���� (entr_interval) ���ɲá�
	����Υ���ȥ���Ͽ���������ְ���Ͽ�����Ͽ���ʤ��褦�ˤ��ޤ�����

2004.01.29 phonondrive  <tdiary@phonondrive.com>
   * version 1.0.1
	replace(��Ͽ)���⥨��ȥ��Ͽ����褦�ˤ��ޤ�����
	����USER-AGENT����θƤӽФ��ˤϷ�̤���Ϥ��ʤ��褦�ˤ��ޤ�����
		��Х���ü�� (tDiary���)
		�ƥ����ȥ֥饦�� (w3m, Lynx, links)
		CSS���б��֥饦�� (Mosaic, Lite, iCab, JustView, WebExplorer)
		�����ܥå� (bot, crawler, Spider, Slurp, inktomi, Sidewinder, naver)
		����¾ (libwww, antenna)

2004.01.28 phonondrive  <tdiary@phonondrive.com>
   * version 1.0.0
=end




# tDiarytimes_textstyle �η�̤���Ϥ��ʤ� USER-AGENT �ꥹ��
# ��Х���ü�����ƥ����ȥ֥饦����CSS���б��֥饦���������ܥåȡ�����ƥʤʤ�
# ��ʸ������ʸ���϶��̤��ޤ���

def tdiarytimes_textstyle_ignore_user_agent; "w3m|Lynx|links|Mosaic|Lite|iCab|JustView|WebExplorer|bot|crawler|Spider|Slurp|inktomi|Sidewinder|naver|libwww|archiver|http|check|WDB|WWWC|WWWD|samidare|tamatebako|NATSU-MICAN|hina|antenna"; end




# --------------------------------------------------------------------
# ������Ͽ���ν���
# --------------------------------------------------------------------

if /^(append|replace)$/ =~ @mode then

	# ���ץ������(����ȥ��ݻ�����)���ɤ߹��ߤ�����

	fade_time = @options['tdiarytimes_textstyle.fade_time'] || 30
	fade_time = 24 * 60 * 60 * fade_time.to_f

	entr_interval = @options['tdiarytimes_textstyle.entr_interval'] || 1
	entr_interval = 60 * 60 * entr_interval.to_f


	# ���ǡ������ɤ߹���

	cache = "#{@cache_path}/tdiarytimes_textstyle"
	Dir::mkdir( cache ) unless File::directory?( cache )

	begin
		io = open("#{cache}/tdiarytimes_textstyle.dat","r")
		ary_data =  Marshal.load(io)
		io.close

		# 1.0.1 >> 1.0.2 ���ǡ����ܹ���
		if ary_data.size == 144
			ary_data.push(Time.now.to_i - entr_interval - 1)
		end

	rescue
		# �����ʤ����ϲ��ǡ������Ѱ�
		ary_data = Array.new(145) {|i| 0 }
	end


	# ���ɥǡ������̿���褿����ȥ��������

	(0..143).each {|i|
		delta = (Time.now.to_i - ary_data[i])/fade_time.to_f
		if delta < 0 || delta > 1
			ary_data[i] = 0
		end
	}


	# ������Ͽ�ֳ֤�вᤷ�Ƥ����顢��������Ͽ���줿�����Ӥ˿���������ȥ�򥻥åȤ���

	if (Time.now.to_i - ary_data[144]) > entr_interval.to_f
		ary_data[(Time.now.strftime('%H').to_i*6 + Time.now.strftime('%M').to_f/10).to_i] = Time.now.to_i
		# �ǽ���Ͽ���֤ε�Ͽ
		ary_data[144] = Time.now.to_i 
	end


	# ���ǡ����ν񤭹���

	io = open("#{cache}/tdiarytimes_textstyle.dat","w")
		Marshal.dump(ary_data,io)
	io.close
end




# --------------------------------------------------------------------
# �ץ饰����ɽ������ư��
# --------------------------------------------------------------------

def tdiarytimes_textstyle (init_text = nil, entr_text = nil, init_color = nil, entr_color = nil, fade_color = nil, init_css = nil, entr_css = nil, title_text = nil, fade_time = nil)


    # ��Х���ü�����ƥ����ȥ֥饦����CSS���б��֥饦���������ܥåȤʤɤˤϷ�̤���Ϥ��ʤ�

    unless @cgi.mobile_agent? || @cgi.user_agent =~ %r[(#{tdiarytimes_textstyle_ignore_user_agent})]i


	r = ""


	# ���ץ�����ͤ��ɤ߹��ߤ�����

	init_text = @options['tdiarytimes_textstyle.init_text'] || "|" unless init_text
	entr_text = @options['tdiarytimes_textstyle.entr_text'] || "|" unless entr_text
	init_color = @options['tdiarytimes_textstyle.init_color'] || "444444" unless init_color
	entr_color = @options['tdiarytimes_textstyle.entr_color'] || "eeeeee" unless entr_color
	fade_color = @options['tdiarytimes_textstyle.fade_color'] || "444444" unless fade_color
	init_css = @options['tdiarytimes_textstyle.init_css'] || "background-color:#444444;" unless init_css
	entr_css = @options['tdiarytimes_textstyle.entr_css'] || "" unless entr_css
	title_text = @options['tdiarytimes_textstyle.title_text'] || "TDIARYTIMES-TEXTSTYLE" unless title_text
	fade_time = @options['tdiarytimes_textstyle.fade_time'] || 30 unless fade_time


	entr_color_rgb = entr_color.unpack("a2a2a2")
	fade_color_rgb = fade_color.unpack("a2a2a2")

	fade_time = 24 * 60 * 60 * fade_time.to_f


	# ���ǡ������ɤ߹���

	cache = "#{@cache_path}/tdiarytimes_textstyle"

	begin
		io = open("#{cache}/tdiarytimes_textstyle.dat","r")
		ary_data =  Marshal.load(io)
		io.close
	rescue
		# ���ե����뤬���Ĥ���ʤ����ϥ��顼�ȥ��ߡ��ǡ�����ɽ��
		r << %Q|Error! cannot open log file.|
		ary_data = Array.new(145) {|i| 0 }
	end


	# html�ǡ����ν���

	r << %Q|<span style="color:##{h init_color};#{h init_css}" title="#{h title_text}">|

	(0..143).each {|i|
		data = ary_data[i]
		if data != 0
			delta = (Time.now.to_i - data)/fade_time.to_f
			if  delta < 0
				# ���ɥ���ȥ��к�
				now_color = init_color
			elsif delta > 1
				# �ե����ɥ����ȴ���Ķ�ᥨ��ȥ��к�
				now_color = fade_color
			else
				# ����ʥ���ȥ�ν���
				now_color = ""
				(0..2).each{|i|
					now_color << format("%02x", entr_color_rgb[i].hex + ((fade_color_rgb[i].hex - entr_color_rgb[i].hex)*delta).to_i)
				}
			end
			r << %Q|<span style="color:##{h now_color};#{h entr_css}" title="#{Time.at(data).strftime('%b %d,%Y')}">#{entr_text}</span>|
		else
			r << %Q|#{init_text}|
		end
	}

	r << %Q|</span>|

    end

end
