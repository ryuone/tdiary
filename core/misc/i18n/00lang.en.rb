#
# 00lang.en.rb: Language support plugin for English
#

#
# header
#
def title_tag
	r = "<title>#{@html_title}"
	case @mode
	when 'day', 'comment'
		r << "(#{@date.strftime( '%Y-%m-%d' )})" if @date
	when 'month'
		r << "(#{@date.strftime( '%Y-%m' )})" if @date
	when 'form'
		r << '(Update)'
	when 'append', 'replace'
		r << '(Update Completed)'
	when 'preview'
		r << '(Preview)'
	when 'showcomment'
		r << '(TSUKKOMI Status Change Completed)'
	when 'conf'
		r << '(Preferences)'
	when 'saveconf'
		r << '(Preferences Changed)'
	when 'nyear'
		years = @diaries.keys.map {|ymd| ymd.sub(/^\d{4}/, "")}
		r << "(#{years[0].sub( /^(\d\d)/, '\1-')}[#{nyear_diary_label @date, years}])" if @date
	end
	r << '</title>'
end


#
# other resources
#
def html_lang
	"en"
end

#
# labels
#
def no_diary; "No diary on #{@date.strftime( @conf.date_format )}"; end
def comment_today; "Today's TSUKKOMI"; end
def comment_total( total ); "(Total: #{total})"; end
def comment_new; 'Add a TSUKKOMI'; end
def comment_description; 'Add a TSUKKOMI or Comment please. E-mail address will be shown to only me.'; end
def comment_description_short; 'TSUKKOMI!!'; end
def comment_name_label; 'Name'; end
def comment_name_label_short; 'Name'; end
def comment_mail_label; 'E-mail'; end
def comment_mail_label_short; 'Mail'; end
def comment_body_label; 'Comment'; end
def comment_body_label_short; 'Comment'; end
def comment_submit_label; 'Submit'; end
def comment_submit_label_short; 'Submit'; end
def comment_date( time ); time.strftime( "(#{@date_format} %H:%M)" ); end
def referer_today; "Today's Link"; end

def navi_index; 'Top'; end
def navi_latest; 'Latest'; end
def navi_oldest; 'Oldest'; end
def navi_update; "Update"; end
def navi_edit; "Edit"; end
def navi_preference; "Preference"; end
def navi_prev_diary(date); "Prev(#{date.strftime(@date_format)})"; end
def navi_next_diary(date); "Next(#{date.strftime(@date_format)})"; end
def navi_prev_nyear(date); "Prev(#{date.strftime('%m-%d')})"; end
def navi_next_nyear(date); "Next(#{date.strftime('%m-%d')})"; end

def submit_label
	if @mode == 'form' or @cgi.valid?( 'appendpreview' ) then
		'Append'
	else
		'Replace'
	end
end
def preview_label; 'Preview'; end
def label_update_complete; '[Update Completed]'; end
def label_reedit; 'Edit Again'; end
def label_hidden_diary; 'This day is HIDDEN now.'; end

def label_no_referer; "Today's Link Excluding List"; end
def label_referer_table; "Today's Link Conversion Rule"; end

def nyear_diary_label(date, years); "my old days"; end
def nyear_diary_title(date, years); "same days in past"; end


#
# labels (for mobile)
#
def mobile_navi_latest; 'Latest'; end
def mobile_navi_update; 'Update'; end
def mobile_navi_preference; 'Prefs'; end
def mobile_navi_prev_diary; 'Prev'; end
def mobile_navi_next_diary; 'Next'; end
def mobile_label_hidden_diary; 'This day is HIDDEN.'; end
