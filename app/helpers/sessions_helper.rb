module SessionsHelper
  
  #grava o cookie quando salva o login
  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user
  end 
  
  #apaga o cookie para forçar o signout
  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end
  
  #metodo usado para verificar se o usuario esta ou nao logado
  def signed_in?
    !current_user.nil?
  end
  
  #usuario esta logado ou não
  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end
  
  
  #atribui o usuario para a variavel de instancia @current_user
  def current_user=(user)
    @current_user = user
  end
  
  #procura o usuario com base no cookie, caso a variavel de instância @current_user esteja = nil
  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end 
  
  #metodo booleano que retorna o usuario corrente (???)
  def current_user?(user)
    user == current_user
  end
  
  # 9.2.3 Friendly forwarding
  # metodos utilizados para armazenar (a pagina desejada pelo usuario), fazer algo necesssário no meio disto,
  # e depois redirecionar um usuario para a pagina original (armazenada)
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url
  end
  
end
