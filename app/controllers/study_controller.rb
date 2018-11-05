class StudyController < ApplicationController
    # ユーザがログインしていないとできない
    before_action :authenticate_user!, only: [:phonics, :words, :listening, :game]
    def phonics
        if params.key?(:page)
            logger.debug "params==> page:" + params[:page]
            logger.debug "params==> num:" + params[:num]
        end
        
        if params.key?(:page)
            # スタディ画面か最後の画面
            @phonic = PhoneticTest.offset(0).first
            render template: 'study/phonics'
        else
            @histories = History.all
            # 最初（履歴）の画面
            render template: 'study/phonics_first'
        end

    end

end
