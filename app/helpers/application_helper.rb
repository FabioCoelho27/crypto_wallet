module ApplicationHelper
    def locale
        I18n.locale == :en ? "Estados Unidos" : "Português do Brasil"
           
       
    end
            
    def data_br(data_us)
        data_us.strftime("%d/%m/%Y")
    end
    def nome_aplicaçao
        "Crypto wallet Apps"
    end
    def o_mestre
        "I'm the better."
    end
end
