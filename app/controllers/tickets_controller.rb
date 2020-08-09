class TicketsController < ApplicationController
  def new
    # ログイン状態では、URLを直接入力する以外ではこのアクションが実行されることはない
    # 未ログイン状態では、newアクションを実行しようとすると authenticate フィルタでイベント一覧ページにリダイレクトする
    raise ActionController::RoutingError, "ログイン状態で TicketsController#new にアクセス"
  end

  def create
    event = Event.find(params[:event_id])
    @ticket = current_user.tickets.build do |t|
      t.event = event
      t.comment = params[:ticket][:comment]
    end

    if @ticket.save
      redirect_to event, notice: "このイベントに参加表明をしました"
    end
  end

  def destroy
    ticket = current_user.tickets.find_by!(event_id: params[:event_id])
    ticket.destroy!
    redirect_to event_path(params[:event_id]), notice: "このイベントの参加をキャンセルしました"
  end
end
