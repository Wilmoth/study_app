class StudyController < ApplicationController
    # ユーザがログインしていないとできない
    before_action :authenticate_user!, only: [:phonics, :words, :listening, :game]
    def phonics
        if session[:answer]
            logger.debug "回答セッション内容:" + session[:answer]
        end
        if params.key?(:page)
            
            logger.debug "params==> page:" + params[:page]
            logger.debug "params==> num:" + params[:num]
        end
        
        if params.key?(:page)
            if PhoneticTest.count <= params[:num].to_i 
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
            @histories = History.where(user_name: current_user.email).order("created_at desc").limit(5)
            # 最初（履歴）の画面
            
            render template: 'study/phonics_first'
        end

    end
    
    private
    
    def phonics_question(num)
        @phonic = PhoneticTest.offset(num).first
    end
    
    
    def incl_num
        # 問題の番号を変数に代入
        num = params[:num].to_i
        # 答えがあるかどうかを確認する
        if params.key?(:answer)
            @num = num + 1 #答えがあればインクリメント
            @message = ""
            # 答えが正解の時その番号をセッションに追記保存
            if params[:correct] == "1" && params[:answer] == "first" \
            || params[:correct] == "2" && params[:answer] == "second" \
            || params[:correct] == "3" && params[:answer] == "third" 
                session[:answer] << @num.to_s + ','
            else
                session[:answer] << '99,'
            end
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
