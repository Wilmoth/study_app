class StudyController < ApplicationController
    # ユーザがログインしていないとできない
    before_action :authenticate_user!, only: [:phonics, :words, :listening, :game]
    def phonics
        if params.key?(:correct)
            logger.debug "params==> correct:" + params[:correct]
        end
        if params.key?(:page)
            logger.debug "params==> page:" + params[:page]
            logger.debug "params==> num:" + params[:num]
        end
        
        if params.key?(:page)
            if params[:num].to_i >= 10
                #最後の問題の時
                num = incl_num
                if @message.empty?
                    #答えがあればインクリメントスコア計算
                    score = calc_score(session[:answer])
                    #Phonicsの問題がない時
                    h = History.new {|d|
                      d.user_name = current_user.email
                      d.study_date = Date.today
                      d.score = score
                      d.section = 1
                      
                    }
                    h.save
                    @score = score
                    render template: 'study/phonics_end'
                else
                    #　問題の番号でDBテーブルから１件取得する
                    phonics_question(num - 1)
                    render template: 'study/phonics'
                end
            else #Phonics のデータがある時
                num = incl_num
                #　問題の番号でDBテーブルから１件取得する
                phonics_question(num - 1)
                render template: 'study/phonics'
            end
        else
            # セッションリセット
            session[:answer] = ''
            session[:rand] = ''
            @histories = History.where(user_name: current_user.email).where(section: 1).order("created_at desc").limit(5)
            # 最初（履歴）の画面
            
            render template: 'study/phonics_first'
        end

    end
    
    def words
        if params.key?(:correct)
            logger.debug "params==> correct:" + params[:correct]
        end
        if params.key?(:page)
            logger.debug "params==> page:" + params[:page]
            logger.debug "params==> num:" + params[:num]
        end
        
        if params.key?(:page)
            if params[:num].to_i >= 10
                #最後の問題の時
                num = incl_num
                if @message.empty?
                    #答えがあればインクリメントスコア計算
                    score = calc_score(session[:answer])
                    #wordsの問題がない時
                    h = History.new {|d|
                      d.user_name = current_user.email
                      d.study_date = Date.today
                      d.score = score
                      d.section = 2
                      
                    }
                    h.save
                    @score = score
                    render template: 'study/words_end'
                else
                    #　問題の番号でDBテーブルから１件取得する
                    words_question(num - 1)
                    render template: 'study/words'
                end
            else #words のデータがある時
                num = incl_num
                #　問題の番号でDBテーブルから１件取得する
                words_question(num - 1)
                render template: 'study/words'
            end
        else
            # セッションリセット
            session[:answer] = ''
            session[:rand] = ''
            @histories = History.where(user_name: current_user.email).where(section: 2).order("created_at desc").limit(5)
            # 最初（履歴）の画面
            
            render template: 'study/words_first'
        end

    end
    def listenings
        if params.key?(:correct)
            logger.debug "params==> correct:" + params[:correct]
        end
        if params.key?(:page)
            logger.debug "params==> page:" + params[:page]
            logger.debug "params==> num:" + params[:num]
        end
        
        if params.key?(:page)
            if params[:num].to_i >= 10
                #最後の問題の時
                num = incl_num
                if @message.empty?
                    #答えがあればインクリメントスコア計算
                    score = calc_score(session[:answer])
                    #Listeningsの問題がない時
                    h = History.new {|d|
                      d.user_name = current_user.email
                      d.study_date = Date.today
                      d.score = score
                      d.section = 3
                      
                    }
                    h.save
                    @score = score
                    render template: 'study/listenings_end'
                else
                    #　問題の番号でDBテーブルから１件取得する
                    listenings_question(num - 1)
                    render template: 'study/listenings'
                end
            else #Phonics のデータがある時
                num = incl_num
                #　問題の番号でDBテーブルから１件取得する
                listenings_question(num - 1)
                render template: 'study/listenings'
            end
        else
            # セッションリセット
            session[:answer] = ''
            session[:rand] = ''
            @histories = History.where(user_name: current_user.email).where(section: 3).order("created_at desc").limit(5)
            # 最初（履歴）の画面
            
            render template: 'study/listenings_first'
        end

    end
    
    
    private
    
    def phonics_question(num)
        # 問題を取り出す
        rnd = get_question_num(10)
        @phonic = PhoneticTest.offset(rnd - 1).first
    end
    
    def words_question(num)
        # 問題を取り出す
        rnd = get_question_num(10)
        @word = Word.offset(rnd - 1).first
    end
    
        def listenings_question(num)
        # 問題を取り出す
        rnd = get_question_num(10)
        @listening = Listening.offset(rnd - 1).first
    end
    
    def get_question_num(max)
        # １から、受け取る数までの乱数を返す
        #c = Random.rand(1 .. max)
        session[:rand] = rand_ses(max, session[:rand])
        if session[:rand]
            logger.debug "randセッション内容:" + session[:rand]
        end
        c = session[:rand].split(",")
        c[-1].to_i # randセッションの最後の要素を返す
    end
    
    def rand_ses(max, s)
      c = s.split(",").first
      if c.nil?
        c = Random.rand(1 .. max)
      elsif s.split(",").count == max
        return s
      else
        while s.split(",").count(c.to_s) >= 1
          c = Random.rand(1 .. max)
          p "rand:" + c.to_s
        end
      end
      s << c.to_s + ","
    end
    
    def incl_num
        # 問題の番号を変数に代入
        num = params[:num].to_i
        # 答えがあるかどうかを確認する
        if params.key?(:answer)
            # 答えが正解の時その番号をセッションに追記保存
            if params[:correct] == "1" && params[:answer] == "first" \
            || params[:correct] == "2" && params[:answer] == "second" \
            || params[:correct] == "3" && params[:answer] == "third" 
                session[:answer] << num.to_s + ','
            else
                session[:answer] << '99,'
            end
            if session[:answer]
                logger.debug "回答セッション内容:" + session[:answer]
            end
            @num = num + 1 #答えがあればインクリメント
            @message = ""
        else
            @num = num
            @message = "こたえ　を　えらんでね"
        end
        num #インクリメントしたnumを返す
    end
    
    def calc_score(str)
        # カンマ区切りの文字列から回答数を取得 
        count = str.split(",").count
        # カンマ区切りの文字列から不正解数を取得 
        incorrect = str.split(",").count("99")
        #正解率計算
        logger.debug "count:" + count.to_s + " incorrect:" + incorrect.to_s
        ((count - incorrect).to_f / count.to_f * 100).to_i 
    end
    

end
