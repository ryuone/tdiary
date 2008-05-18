# tdiarytimes.rb $originalRevision: 1.1 $
#
# Copyright (c) 2003 neuichi <neuichi@nmnl.jp>
# Distributed under the GPL
#
# 2003-12-01 circle extention added by Minero Aoki <aamine@loveruby.net>
# $Id: tdiarytimes2.rb,v 1.2 2007-01-11 02:55:26 tadatadashi Exp $
#
# �ץ饰�������ۥڡ���
# http://i.loveruby.net/w/tdiarytimes.html
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
# @options['tdiarytimes.fadeout'] = false
# �ե����ɥ����Ȥ��뤫���ǥե���Ȥ�false��
# �ե����ɥ����Ȥ������Ȥ��ˤ� true �ˤ���Ф褤��
#
# @options['tdiarytimes.fadeoutcolor'] = '#ffffff'
# �ե����ɥ����Ȥ���Ȥ���
# �ǥե���ȤǤ�fillcolor�ؤȥե����ɥ����Ȥ��Ƥ�����
# �����ǿ�����ꤹ��Ȥ��ο��ؤȥե����ɥ����Ȥ��Ƥ�����
# �ǥե���Ȥ� false
# 
# @options['tdiarytimes.text'] = 'T D I A R Y T I M E S'
# ���Ϥ���ʸ�����ǥե���Ȥ�'T D I A R Y T I M E S'���ʤ�Ⱦ�ѱѿ����Τ��б���
# 
# @options['tdiarytimes.day'] = 30
# ������¸��������������ǥե���Ȥ�30��
# ���ξ�硢30���ʾ�Фä��ǡ����Ͼõ�졢�����Ȥ������褵��ʤ��ʤ롣
#

require 'GD'

::GD::Image.module_eval {
  def tiny_string(text, x, y, color)
    string(GD::Font::TinyFont, x, y, text, color)
  end

  def small_string(text, x, y, color)
    string(GD::Font::SmallFont, x, y, text, color)
  end
}

# Ruby 1.6 missing File.read
unless ::File.respond_to?(:read)
  def (::File).read(fname)
    File.open(fname) {|f|
      return f.read
    }
  end
end

# Ruby 1.6 missing MatchData#captures
unless ::MatchData.method_defined?(:captures)
  ::MatchData.module_eval {
    def captures
      a = to_a()
      a.shift
      a
    end
  }
end

class TDiaryTimes
  class << TDiaryTimes
    alias newobj new
  end

  def TDiaryTimes.new(datadir, options)
    case options['tdiarytimes.shape']
    when 'bar', nil
      c = TDiaryTimesBar
    when 'circle'
      c = TDiaryTimesCircle
    else
      raise ArgumentError, "unknown tdiarytimes.shape: #{options['tdiarytimes.shape']}"
    end
    c.newobj("#{datadir}/tdiarytimes", options)
  end

  def initialize(dbfile, options)
    @dbfile     = dbfile
    @image_file = options['tdiarytimes.file'] || 'tdiarytimes.png'
    @day        = options['tdiarytimes.day'] || 30
    @keepdb     = options['tdiarytimes.keepdb']
  end

  attr_reader :image_file

  def update_image
    now = Time.now
    mtimes = (load_database() + [now]).reject {|tm|
               (now - tm) > (60 * 60 * 24 * @day)
             }
    image = create_image(mtimes)
    File.open(@image_file, 'w') {|png|
      image.png(png)
    }
    save_database(mtimes) unless @keepdb
  end

  private

  #
  # database
  #

  def load_database
    begin
      return Marshal.load(File.read(@dbfile))
    rescue Errno::ENOENT
      return []
    end
  end

  def save_database(content)
    File.open(@dbfile, 'w') {|f|
      Marshal.dump(content, f)
    }
  end

  #
  # common paint methods
  #

  def fadeout_color(srccolor, destcolor, time)
    par = (Time.now - time).to_f / (60 * 60 * 24 * @day)
    r, g, b = *zip(parse_rgb(srccolor), parse_rgb(destcolor))\
        .map {|src, dest| src - (src - dest) * par }.map {|c| c.to_i }
    sprintf('#%02x%02x%02x', r, g, b)
  end

  def parse_rgb(str)
    hex = '[\da-f]'
    m = /\A\#(#{hex}{2})(#{hex}{2})(#{hex}{2})\z/io.match(str) or
        raise ArgumentError, "tdiarytimes: not color: #{str.inspect}"
    m.captures.map {|c| c.hex }
  end

  def zip(*lists)
    result = []
    lists[0].each_index do |idx|
      result.push lists.map {|lst| lst[idx] }
    end
    result
  end
end

class TDiaryTimesBar < TDiaryTimes
  def initialize(dbfile, options)
    super
    @text         = options['tdiarytimes.text'] || 'T D I A R Y T I M E S'
    @width        = options['tdiarytimes.width'].to_i || 400
    @height       = options['tdiarytimes.height'].to_i || 20
    @textcolor    = options['tdiarytimes.textcolor'] || '#444444'
    @fillcolor    = options['tdiarytimes.fillcolor'] || '#444444'
    @linecolor    = options['tdiarytimes.linecolor'] || '#ffffff'
    @fadeoutcolor = options['tdiarytimes.fadeoutcolor'] || @fillcolor
    @fadeoutp     = options['tdiarytimes.fadeout']
  end

  def html(alt)
    %Q[<img src="#{h image_file()}"
            alt="#{h( alt || @text )}"
            width="#{@width + GAP_W}"
            height="#{@height + GAP_H}"
            class="tdiarytimes">].gsub(/\s+/, ' ')
  end

  private

  GAP_W = 16
  GAP_H = 16

  def create_image(mtimes)
    image = GD::Image.new(@width + GAP_W, @height + GAP_H)
    image.transparent(image.colorAllocate('#fffffe'))
    image.interlace = true

    image.tiny_string @text, (GAP_W / 2), 0, image.colorAllocate(@textcolor)
    image.filledRectangle           0 + GAP_W / 2,            0 + GAP_H / 2,
                          image.width - GAP_W / 2, image.height - GAP_H / 2,
                          image.colorAllocate(@fillcolor)
    if @fadeoutp
      paint_lines_fadeout image, mtimes, @linecolor, @fadeoutcolor
    else
      paint_lines         image, mtimes, @linecolor
    end
    paint_hours image, image.colorAllocate(@textcolor),
                (image.width - GAP_W > 160 ? 2 : 4)

    image
  end

  def paint_lines(image, mtimes, color)
    gdcolor = image.colorAllocate(color)
    mtimes.each do |time|
      line image, time, gdcolor
    end
  end

  def paint_lines_fadeout(image, mtimes, linecolor, destcolor)
    mtimes.each do |time|
      line image, time,
           image.colorAllocate(fadeout_color(linecolor, destcolor, time))
    end
  end

  def line(image, time, color)
    x0 = (image.width - GAP_W).to_f * (time.hour * 60 + time.min) / (60 * 24)
    x = (x0 + (GAP_W / 1.25)).to_i
    image.line x,            0 + (GAP_H / 2),
               x, image.height - (GAP_H / 2),
               color
  end

  def paint_hours(image, color, stepping)
    0.step(24, stepping) do |hour|
      image.tiny_string hour.to_s,
          (image.width - GAP_W) * (hour.to_f / 24) + (GAP_W / 2) - 4,
          image.height - (GAP_H / 2),
          color
    end
  end
end

class TDiaryTimesCircle < TDiaryTimes
  def initialize(dbfile, options)
    super
    #@text   # cannot change now
    @width        = options['tdiarytimes.width'].to_i || 80
    @height       = options['tdiarytimes.height'].to_i || 80
    @textcolor    = options['tdiarytimes.textcolor'] || '#444444'
    @fillcolor    = options['tdiarytimes.fillcolor'] || '#444444'
    @linecolor    = options['tdiarytimes.linecolor'] || '#ffffff'
    @fadeoutcolor = options['tdiarytimes.fadeoutcolor'] || @fillcolor
    @fadeoutp     = options['tdiarytimes.fadeout']
  end

  def html(alt)
    %Q[<img src="#{h image_file()}"
            alt="#{h( alt || '' )}"
            width="#{@width}"
            height="#{@height}"
            class="tdiarytimes">].gsub(/\s+/, ' ')
  end

  private

  MIN_DEGREE = 0
  MAX_DEGREE = 250
  BAR_WIDTH = 24
  TRANSCOLOR = '#ffffff'

  def create_image(mtimes)
    image = GD::Image.new(@width, @height)
    trans = image.colorAllocate(TRANSCOLOR)
    image.transparent trans
    image.interlace = true

    paint_outer_circle image, trans
    if @fadeoutp
      paint_lines_fadeout image, mtimes, @linecolor, @fadeoutcolor
    else
      paint_lines         image, mtimes, @linecolor
    end
    paint_inner_circle image, trans
    textcolor = image.colorAllocate(@textcolor)
    image.small_string 'tdiary', @width / 2 + 1, 11, textcolor
    image.small_string 'times',  @width / 2 + 4, 21, textcolor

    image
  end

  def paint_outer_circle(image, trans)
    image.filledArc @width / 2, @height / 2,
                    @width, @height,
                    MIN_DEGREE, MAX_DEGREE,
                    if @fillcolor == TRANSCOLOR
                        then trans
                        else image.colorAllocate(@fillcolor)
                        end,
                    0
  end

  def paint_inner_circle(image, trans)
    image.filledArc @width / 2, @height / 2,
                    @width - BAR_WIDTH * 2,
                    (@width - BAR_WIDTH * 2) * (@height.to_f / @width),
                    0, 360, trans, 0
  end

  def paint_lines(image, mtimes, color)
    gdcolor = image.colorAllocate(color)
    mtimes.each do |time|
      line image, time, gdcolor
    end
  end

  def paint_lines_fadeout(image, mtimes, linecolor, destcolor)
    mtimes.each do |time|
      line image, time,
           image.colorAllocate(fadeout_color(linecolor, destcolor, time))
    end
  end

  def line(image, time, color)
    d0 = (time.hour * 60 + time.min).to_f / (60 * 24)
    d = MIN_DEGREE + (MAX_DEGREE - MIN_DEGREE) * d0
    image.line @width / 2, @height / 2,
               @width  / 2 + degcos(d) * (@width  / 2) * 0.95,
               @height / 2 + degsin(d) * (@height / 2) * 0.95,
               color
  end

  include Math

  def degsin(d)
    sin(d / (180 / Math::PI))
  end

  def degcos(d)
    cos(d / (180 / Math::PI))
  end
end

def tdiarytimes(alt = nil)
  TDiaryTimes.new(@conf.data_path, @options).html(alt)
end


if $0 == __FILE__   # debugging
  tmp_options_bar = {
    'tdiarytimes.shape'     => 'bar',
    'tdiarytimes.textcolor' => '#666666',
    'tdiarytimes.linecolor' => '#df0000',
    'tdiarytimes.fillcolor' => '#0f5f0f',
    'tdiarytimes.fadeout'   => true,
    'tdiarytimes.keepdb'    => false   # for debug
  }
  tmp_options_circle = {
    'tdiarytimes.shape'     => 'circle',
    'tdiarytimes.textcolor' => '#000000',
    'tdiarytimes.linecolor' => '#bfbfbf',
    'tdiarytimes.fillcolor' => '#2f2f7f',
    'tdiarytimes.fadeout'   => true,
    'tdiarytimes.keepdb'    => false   # for debug
  }

  @mode = 'latest'
  @conf = Object.new
  def @conf.data_path
    '.'
  end
  case ARGV[0]
  when 'bar'
    @options = tmp_options_bar
  else
    @options = tmp_options_circle
  end
  TDiaryTimes.new(@conf.data_path, @options).update_image
  puts tdiarytimes()
  exit 0
end

if /append|replace/ =~ @mode
  TDiaryTimes.new(@conf.data_path, @options).update_image
end
