module Noodall

  class Admin::RedirectsController < Noodall::Admin::BaseController
    sortable_attributes :from, :to
    def index
      @redirects = Noodall::RewriteRule.paginate :page => params[:page], :per_page => 20, :order => sort_order(:default => 'asc')
    end

    def new
      @redirect = Noodall::RewriteRule.new
    end

    def create
      @redirect = Noodall::RewriteRule.new(params[:noodall_rewrite_rule])

      if @redirect.save
        flash[:notice] = 'Redirect successfully created.'
        redirect_to noodall_admin_redirects_path
      else
        render :action => 'new'
      end
    end

    def edit
      @redirect = Noodall::RewriteRule.find(params[:id])
    end

    def update
      @redirect = Noodall::RewriteRule.find(params[:id])

      if @redirect.update_attributes(params[:noodall_rewrite_rule])
        flash[:notice] = 'Redirect successfully updated.'
        redirect_to(noodall_admin_redirects_url)
      else
        render :action => "show"
      end
    end

    def destroy
      @redirect = Noodall::RewriteRule.find(params[:id])

      @redirect.destroy
      flash[:notice] = 'Redirect successfully deleted.'

      redirect_to(noodall_admin_redirects_url)
    end
  end
end