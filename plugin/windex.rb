#!/usr/bin/env ruby
# windex.rb $Revision: 1.1 $
#
# windex: ��������������
#   �ѥ�᥿:
#     str:      �������ʸ����
#     readname: �ɤ߲�̾
#
# ���Υե������tDiary�Υȥåץǥ��쥯�ȥ�ˤ����֤���
# CGI�Ȥ��Ƽ¹Ԥ��뤳�ȤǺ����ڡ�������ϤǤ��ޤ���
#
# Copyright (c) 2003 Gony <gony@sm.rim.or.jp>
# Distributed under the GPL
#

$KCODE= "e"

mode = ""
if $0 == __FILE__
	mode = "CGI"
	if FileTest.symlink?(__FILE__)
		org_path = File.dirname(File.readlink(__FILE__))
	else
		org_path = File.dirname(__FILE__)
	end
	$:.unshift(org_path)
	require "pstore"
	require "tdiary"
else
	add_update_proc do
		wordindex = WIWordIndex.new
		wordindex.generate(@diaries,self,@conf.index)
		wordindex.save(@cache_path + "/windex",@date.strftime('%Y%m'))
	end
end

def windex(str,readname = "")
	return str
end

class WITDiary < TDiary::TDiaryBase
	def load_plugins
		super
	end
end

class WIWordIndex
	def initialize
		@windex = {}
	end

	def generate(diaries,plugin,index)
		diaries.each_value do |diary|
			num_section = 1
			diary.each_section do |section|
				anchor = index \
					   + plugin.anchor(diary.date.strftime("%Y%m%d")) \
					   + "#p%02d" % num_section
				if section.subtitle != nil
					scan(section.subtitle,anchor)
				end
				scan(section.body,anchor)
				num_section = num_section + 1
			end
		end
	end

	def generate_html
		body = ""

		# �����̾ => ̾�������� �Υϥå��������
		subindex_to_name = {}
		@windex.keys.each do |key|
			subindex = ""
			if @windex[key]["readname"] != nil
				subindex = get_subindex(@windex[key]["readname"])
			else
				subindex = get_subindex(key)
			end
			if subindex_to_name.has_key?(subindex) != true
				subindex_to_name[subindex] = []
			end
			subindex_to_name[subindex] << key
		end

		# �����̾���Ȥ�HTML������
		if subindex_to_name.has_key?("����") == true
			body += generate_html_subindex(subindex_to_name,"����")
		end
		subindex_to_name.keys.sort.each do |key|
			if key != "����" 
				body += generate_html_subindex(subindex_to_name,key)
			end
		end

		return body
	end

	def load(dir)
		@windex = {}
		PStore.new(dir + "/windex").transaction do |pstore|
			roots = pstore.roots
			roots.each do |key|
				windex_tmp = pstore[key]
				windex_tmp.each_key do |key_windex|
					if @windex.has_key?(key_windex) != true
						@windex[key_windex] = {"readname" => nil,
											   "anchor" => []}
					end
					if @windex[key_windex]["readname"] == nil \
						&& windex_tmp[key_windex].has_key?("readname") == true
							@windex[key_windex]["readname"] = windex_tmp[key_windex]["readname"]
					end
					@windex[key_windex]["anchor"].concat(windex_tmp[key_windex]["anchor"])
				end
			end
		end
	end

	def save(dir,keyname)
		if File.directory?(dir) == false
			Dir.mkdir(dir,0755)
		end
		PStore.new(dir + "/windex").transaction do |pstore|
			pstore[keyname] = @windex
		end
	end

private
	def generate_html_subindex(subindex_to_name,key)
		readname_to_name = {}
		subindex_to_name[key].each do |name|
			key_new = ""
			if @windex[name]["readname"] != nil
				key_new = @windex[name]["readname"]
			else
				key_new = name
			end
			if readname_to_name.has_key?(key_new) != true
				readname_to_name[key_new] = []
			end
			readname_to_name[key_new] << name
		end

		body = %Q[<div class="section"><h2>#{key}</h2>\n]

		# �ɤ߲�̾�Υ����Ȥǥ롼�� -> ̾���Υ����Ȥǥ롼��
		keys = readname_to_name.keys
		if keys.empty? == false
			keys.sort.each do |readname|
				readname_to_name[readname].sort.each do |name|
					body = body + "<p>#{name} ... "
					num_anchor = 1
					@windex[name]["anchor"].sort.each do |anchor|
						body = body + %Q[<a href="#{anchor}">#{num_anchor}</a>]
						if num_anchor < @windex[name]["anchor"].length
							body = body + ","
						end
						num_anchor = num_anchor + 1
					end
					body = body + "</p>"
				end
			end
		end
		body = body + "\n</div>\n"

		return body
	end

	def scan(body,anchor)
		to_delimiter_end = 
		{
			"(" => ")","[" => "]","{" => "}","<" => ">",
		}

		wistrs = body.scan(%r[<%\s*=\s*windex\s*[^(<%)]*\s*%>])
		wistrs.each do |wistr|
			# �������
			argstr = wistr.gsub(%r[<%\s*=\s*windex\s*],"")
			argstr = argstr.gsub(%r[\s*%>],"")
			args = []
			flag_done = false
			while flag_done == false
				pos_delimiter = argstr =~ %r['|"|%[Qq].]
				if pos_delimiter != nil
					# �ǥ�ߥ�ʸ������
					delimiter = argstr.scan(%r['|"|%[Qq].])[0]
					if delimiter.length == 3
						delimiter_end = delimiter[2].chr
						if to_delimiter_end.has_key?(delimiter_end)
							delimiter_end = to_delimiter_end[delimiter_end]
						end
					else
						delimiter_end = delimiter
					end

					# �ǥ�ߥ��ޤǤ�ʸ�������
					argstr = argstr[(pos_delimiter + delimiter.length)..-1]
					pos_delimiter = argstr =~ delimiter_end
					if pos_delimiter != nil
						if pos_delimiter > 0
							# �����Ȥ��Ƽ���
							args << argstr[0..(pos_delimiter - 1)]
						end
						# �ǥ�ߥ��ޤǤ�ʸ�������
						argstr = argstr[(pos_delimiter + delimiter_end.length)..-1]
					else
						flag_done = true
					end
				else
					flag_done = true
				end
			end

			if args.length > 0
				if @windex.has_key?(args[0]) != true
					# �ϥå��������
					@windex[args[0]] = {"readname" => nil,"anchor" => []}
				end
				if args.length == 2 && @windex[args[0]]["readname"] == nil
					@windex[args[0]]["readname"] = args[1]
				end
				@windex[args[0]]["anchor"] << anchor
			end
		end
	end

	def get_subindex(name)
		to_plainhiragana = 
		{
			"��" => "��","��" => "��","��" => "��","��" => "��","��" => "��",
			"��" => "��","��" => "��","��" => "��","��" => "��","��" => "��",
			"��" => "��","��" => "��","��" => "��","��" => "��","��" => "��",
			"��" => "��","��" => "��","��" => "��","��" => "��","��" => "��","��" => "��",
			"��" => "��","��" => "��","��" => "��","��" => "��","��" => "��","��" => "��","��" => "��","��" => "��","��" => "��","��" => "��",
			"��" => "��","��" => "��","��" => "��",
			"��" => "��","��" => "��","��" => "��","��" => "��",
		}
		to_1byte = 
		{
			"��" => "!",'��' => '"',"��" => "#","��" => "$","��" => "%","��" => "&","��" => "'","��" => "(","��" => ")","��" => "*","��" => "+","��" => ",","��" => "-","��" => ".","��" => "/",
			"��" => "0","��" => "1","��" => "2","��" => "3","��" => "4","��" => "5","��" => "6","��" => "7","��" => "8","��" => "9","��" => ":","��" => ";","��" => "<","��" => "=","��" => ">","��" => "?",
			"��" => "@","��" => "A","��" => "B","��" => "C","��" => "D","��" => "E","��" => "F","��" => "G","��" => "H","��" => "I","��" => "J","��" => "K","��" => "L","��" => "M","��" => "N","��" => "O",
			"��" => "P","��" => "Q","��" => "R","��" => "S","��" => "T","��" => "U","��" => "V","��" => "W","��" => "X","��" => "Y","��" => "Z","��" => "[","��" => "\\","��" => "]","��" => "^","��" => "_",
			"��" => "a","��" => "b","��" => "c","��" => "d","��" => "e","��" => "f","��" => "g","��" => "h","��" => "i","��" => "j","��" => "k","��" => "l","��" => "m","��" => "n","��" => "o",
			"��" => "p","��" => "q","��" => "r","��" => "s","��" => "t","��" => "u","��" => "v","��" => "w","��" => "x","��" => "y","��" => "z","��" => "{","��" => "|","��" => "}","��" => "~"
		}

		topchr = name[0,1]
		if topchr.count("\xA1-\xFE") == 1
			# 2�Х���ʸ��
			topchr = name[0,2]
		end
		if to_1byte.has_key?(topchr) == true
			topchr = to_1byte[topchr]
		end
		if topchr.length == 1
			# 1�Х���ʸ���ν���
			topchr = topchr.upcase
			
			if (0x21 <= topchr[0] && topchr[0] <= 0x2F) \
				|| (0x3A <= topchr[0] && topchr[0] <= 0x40) \
				|| (0x5B <= topchr[0] && topchr[0] <= 0x60) \
				|| (0x7B <= topchr[0] && topchr[0] <= 0x7B)
					topchr = "����"
			end
		else
			# 2�Х���ʸ���ν���
			# ��������->�Ҥ餬���Ѵ�
			code = topchr[0] * 0x100 + topchr[1]
			if 0xA5A1 <= code && code <= 0xA5F3
				topchr = 0xA4.chr + topchr[1].chr
			end

			# ���� / Ⱦ���� �����ʤ��Ѵ�
			if to_plainhiragana.has_key?(topchr) == true
				topchr = to_plainhiragana[topchr]
			end
		end
		return topchr
	end
end

if mode == "CGI"
	cgi = CGI.new
	conf = TDiary::Config.new
	cache_path = conf.data_path + "cache"
	plugin = WITDiary.new(cgi,"day.rhtml",conf).load_plugins

	# �ܥǥ�����
	wordindex = WIWordIndex.new
	wordindex.load(cache_path + "/windex")
	body = <<BODY
		<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
		<html>
			<head>
				<title>#{conf.html_title}(����)</title>
				#{plugin.css_tag}
			</head>
			<body>
				<h1>#{conf.html_title} [����]</h1>
				<div class="day"><div class="body">
					#{wordindex.generate_html}
				</div></div>
			</body>
		</html>
BODY

	# �إå�����
	header = 
	{
		"type" => "text/html",
		"charset" => "EUC-JP",
		"Content-Length" => body.size.to_s,
		"Pragma" => "no-cache",
		"Cache-Control" => "no-cache",
		"Vary" => "User-Agent",
	}
	head = cgi.header(header)

	# ����
	print head
	print body
end
