# Copyright (C) 2007, KURODA Hiraku <hiraku@hinet.mydns.jp>
# You can redistribute it and/or modify it under GPL2. 

class SpambayesConfig
	module Res
		module_function

		def title
			"Bayes�ե��륿"
		end

		def check_comment
			"�ĥå��ߤ��ǧ����"
		end

		def check_referer
			"��󥯸����ǧ����"
		end

		def token_list(type)
			"#{type}�ȡ��������"
		end

		def rebuild_db
			"�ǡ����١����κƹ���"
		end

		def use_bayes_filter
			"Bayes�ե��륿��Ȥ�"
		end

		def use_filter_to_referer
			"��󥯸���Bayes�ե��륿��Ȥ�"
		end

		def save_error_log
			"���顼���򥭥�å���ǥ��쥯�ȥ����¸"
		end

		def threshold
			"����"
		end

		def receiver_addr
			"����᡼�륢�ɥ쥹"
		end

		def stay_ham
			"�ϥ�Τޤ�"
		end

		def register_ham
			"�ϥ�Ȥ�����Ͽ"
		end

		def stay_spam
			"���ѥ�Τޤ�"
		end

		def register_spam
			"���ѥ�Ȥ�����Ͽ"
		end

		def comment_processed
			"�ĥå��ߤ�������ޤ���"
		end

		def token
			"�ȡ�����"
		end

		def probability(type)
			"#{type}Ψ"
		end

		def score_in_db(type)
			"#{type}�ǡ����١����ǤΥ�����"
		end

		def execute_after_click_OK
			"OK�򲡤��ȼ¹Ԥ��ޤ�"
		end

		def registered_as(type)
			"#{type}�Ȥ�����Ͽ���ޤ���"
		end

		def rebuild_db_after_click_OK
			"OK�򲡤��ȥ����ѥ�����ǡ����١�����ƺ������ޤ�"
		end

		def processed_referer
			"��󥯸���������ޤ���"
		end

		def token_of_referer
			"��󥯸��Υȡ�����"
		end

		def mail
			"�᡼�륢�ɥ쥹"
		end

		def posted_host_addr
			"��ƥۥ��Ȥ�IP"
		end

		def name
			"̾��"
		end

		def referer
			"��󥯸�"
		end

		def url_in_comment
			"���������URL"
		end

		def comment_body_and_keyword
			"��������ʸ�ȸ�����󥯸��Υ������"
		end

		def no_token_exist
			"(�ȡ����󤬤���ޤ���)"
		end
	end
end
