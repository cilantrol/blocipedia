class ChargesController < ApplicationController

after_action :subscription, only:  [:create, :update]

  def create
    # def not relevant
      # @amount = params[:amount]
      # @amount = @amount.gsub('$', '').gsub(',', '')

      # begin
      #   @amount = Float(@amount).round(2)
      # rescue
      #   flash[:error] = 'Charge not completed. Please enter a valid amount in USD ($).'
      #   redirect_to new_charge_path
      #   return
      # end

    # @amount = (@amount * 100).to_i # Must be an integer!
    # end

    # Creates a Stripe Customer object, for associating
    # with the charge
    customer = Stripe::Customer.create(
    email: current_user.email,
    card: params[:stripeToken]
    )

    # Where the real magic happens
    charge = Stripe::Charge.create(
    customer: customer.id, # Note -- this is NOT the user_id in your app
    amount: 1000,
    description: "Upgrading To Premium Subscription - #{current_user.email}",
    currency: 'usd'
    )

    flash[:notice] = "Thanks for all the money, #{current_user.email}! Feel free to pay me again."
    # redirect_to user_path(current_user) # or wherever
    redirect_to edit_user_registration_path(current_user)

    # Stripe will send back CardErrors, with friendly messages
    # when something goes wrong.
    # This `rescue block` catches and displays those errors.
    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Upgrading To Premium Subscription - #{current_user.email}",
      amount: 1000
    }
  end

  def cancelation
    current_user.update_attribute(:role, 'standard')
    #remove from stripe db
    # find all Wikis
    # loop through it
    # Wiki.user == current_user
    #   set private = false
    # end
    flash[:notice] = "Back to Standard & Free, #{current_user.email}."
    redirect_to edit_user_registration_path(current_user)
  end

  private

  def subscription
    current_user.update_attribute(:role, 'premium')
  end

end
