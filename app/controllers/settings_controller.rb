class SettingsController < ApplicationController

  before_action :signed_in_user
  before_action :define_user

  def index
    @tab = params[:tab]
    @locale = cookies.permanent[:current_locale] || 'ru'
    @items_per_page = items_per_page
  end

  def update_settings
    l = params[:locale].to_s.strip.to_sym
    l = I18n.default_locale unless I18n.available_locales.include?(l)
    cookies.permanent[:current_locale] = l

    i = params[:items_per_page].to_s.strip.to_i
    cookies.permanent[:items_per_page] = i

    flash[:success] = t('settings_page.saved')
    redirect_to settings_tab_path(:settings) || root_url
  end

  def update_user
    if @user.update_attributes(user_params)
      flash[:success] = t('settings_page.saved')
    end
    index
    @tab = 'account'
    render :index
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  def define_user
    @user = @current_user unless @user
  end

end
