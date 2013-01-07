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
end
