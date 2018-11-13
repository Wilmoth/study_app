class StudyController < ApplicationController
    # ユーザがログインしていないとできない
    before_action :authenticate_user!, only: [:phonics, :words, :listening, :game]
    def phonics
        
        if params.key?(:page)
            
            logger.debug "params==> page:" + params[:page]
            logger.debug "params==> num:" + params[:num]
        end
        
        if params.key?(:page)
            num = params[:num].to_i
            count = PhoneticTest.count
            if count == num 
                #Phonicsの問題がない時
                render template: 'study/phonics_end'
            else #Phonics のデータがある時
                if params.key?(:answer)
                    @num = num + 1 #答えがあればインクリメント
                    @message = ""
                else
                    @num = num
                    @message = "こたえ　を　えらんでね"
                end
                @phonic = PhoneticTest.offset(num - 1).first
                render template: 'study/phonics'
            end
        else
            @histories = History.all
            # 最初（履歴）の画面
            
            render template: 'study/phonics_first'
        end

    end

end
