class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.all
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = current_user.messages.build
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = current_user.messages.build(message_params)

    respond_to do |format|
      if @message.save
        deliver @message
        format.html { redirect_to @message, notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def nexmo
      require 'nexmo'
      # We do not pass in any API key or secret as
      # we're using environment variables `NEXMO_API_KEY`
      # and `NEXMO_API_SECRET`
      client = Nexmo::Client.new(
        key: ENV["NEXMO_API_KEY"],
        secret: ENV["NEXMO_API_SECRET"]
      )
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:to, :from, :text)
    end

    # Uses the Nexmo API to send the stored
    # SMS message
    def deliver message
      response = nexmo.send_message(
        from: current_user.phone_number,
        to: message.to,
        text: message.text
      )

      # If sending the SMS was a success then store
      # the message ID on the SMS record

      #if response['messages'].first['status'] == '0'
        #message.update_attributes(
        #  message_id: response['messages'].first['message-id']
        #)
      #end


    end
end
