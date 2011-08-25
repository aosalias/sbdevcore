class ContactsController < ApplicationController
  before_filter :get_index, :only => [:new]
  before_filter :authenticate_admin!, :except => [:new, :create]
  
  def index
    @contacts = Contact.all
  end
  
  def show
    @contact = Contact.find(params[:id])
  end
  
  def new
    @contact = Contact.new
    render :layout => false
  end
  
  def create
    @contact = Contact.new(params[:contact])
    if @contact.save
      flash[:notice] = "Your message has been sent."
      redirect_to root_url
    else
      render :action => 'new'
    end
  end
  
  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy
    flash[:notice] = "Successfully destroyed contact."
    redirect_to contacts_url
  end

  def get_index
    @index = Index.find_by_name(controller_name)
  end
end
