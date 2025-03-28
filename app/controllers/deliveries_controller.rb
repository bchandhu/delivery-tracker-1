class DeliveriesController < ApplicationController
  def index
    matching_deliveries = Delivery.where({:user_id => current_user})

    @list_of_deliveries = matching_deliveries.order({ :created_at => :desc })

    @waiting_on_deliveries = matching_deliveries.where({ :arrived => false }).order({ :supposed_to_arrived_on => :asc })

    @received_deliveries = matching_deliveries.where({ :arrived => true }).order({ :updated_at => :asc })
  

    render({ :template => "deliveries/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_deliveries = Delivery.where({ :id => the_id })

    @the_delivery = matching_deliveries.at(0)

    render({ :template => "deliveries/show" })
  end

  def create
    the_delivery = Delivery.new
    the_delivery.user_id = params.fetch("query_user_id")
    the_delivery.description = params.fetch("query_description")
    the_delivery.details = params.fetch("query_details")
    the_delivery.supposed_to_arrived_on = params.fetch("query_supposed_to_arrived_on")
    the_delivery.arrived = params.fetch("query_arrived")

    if the_delivery.valid?
      the_delivery.save
      redirect_to("/deliveries", { :notice => "Added to list." })
    else
      redirect_to("/deliveries", { :alert => the_delivery.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_delivery = Delivery.where({ :id => the_id }).at(0)

    #the_delivery.user_id = params.fetch("query_user_id")
    the_delivery.description = params.fetch("query_description", the_delivery.description)
    the_delivery.supposed_to_arrived_on = params.fetch("query_supposed_to_arrived_on", the_delivery.supposed_to_arrived_on)
    the_delivery.arrived = params.fetch("arrived", false)

    if the_delivery.valid?
      the_delivery.save
      redirect_to("/deliveries", notice: "Delivery updated successfully.")

    else
      redirect_to("/deliveries/#{the_delivery.id}", { :alert => the_delivery.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_delivery = Delivery.where({ :id => the_id }).at(0)

    the_delivery.destroy

    redirect_to("/deliveries", { :notice => "Delivery deleted successfully."} )
  end
end
