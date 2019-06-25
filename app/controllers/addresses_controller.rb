class AddressesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:webhook, :verify]

  def new
  	@address = NewAddress.new
  end

  def verify
    @address = Address.find_by_verification_code(params[:verification_code])
    if @address
      resp = @address.letter['to'].slice('address_line1', 'address_line2', 'address_city', 'address_state', 'address_zip', 'address_country', 'company', 'name')
      if @address.activated
        render json: {status: 'already_activated', address: resp}, status: 200
      else
        @address.update activated: true
        render json: {status: 'success', address: resp}, status: 200
      end
      
    else
      render plain: 'Invalid code', status: 401
    end
  end

  def webhook
    puts params
    @event = Event.new
    @event.event_id = params[:id]
    @event.reference_id = params[:body][:id]
    @event.event_type = params[:event_type][:id]
    @event.event_date = params[:date_created]
    @event.body = params[:body]

    if @event.save
      if @event.event_type == 'letter.rendered_pdf'
        @address = Address.find_by_letter_id(@event.reference_id)
        file = open(params[:body][:url])
        @address.verification_letter.attach(io: file, filename: "verification-#{@event.id}.pdf")
      end
      render plain: 'success'
    else
      render plain: 'error'
    end
  end

  def show
    @address = Address.find(params[:id])
    @events = Event.where(reference_id: @address.letter_id)
  end

  def create
  	@address = NewAddress.run(address_params)
  	if @address.valid?
  		redirect_to address_path(@address.result), notice: 'Address added!'
  	else
  		render :new, notice: "Error"
  	end
  end

  private

  def address_params
  	params.require(:new_address).permit(:first_name, :last_name, :line1, :line2, :city, :state, :zip)
  end
end
