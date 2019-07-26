namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      # show_spinner("Apagando DB....","Concluído)") { %x(rails db:drop)}
      # show_spinner("Criando DB","Concluído)") { %x(rails db:create)}
      show_spinner("Migrando DB","Concluído)") { %x(rails db:migrate)}
      %x(rails dev:add_mining_types)
      %x(rails dev:add_coins)
    else
      puts "voce nao esta em modo de desenvolvimento!"
  end
end

desc "Cadastra as Moedas"
task add_coins: :environment do
  show_spinner("Cadastrando Moedas...", "Concluído)"  )do
    coins = [
      {
        description:"Bitcoin",
        acronym:"Btc",
        url_image:"http://pngimg.com/uploads/bitcoin/bitcoin_PNG47.png",
        mining_type: MiningType.find_by(acronym:'PoW')

      },
      {
        description:"Ethereum",
        acronym:"ET",
        url_image:"ttps://www.edureka.co/blog/wp-content/uploads/2018/05/Ethereum-icon-what-is-ethereum-edureka-1.png",
        mining_type: MiningType.find_by(acronym:'PoS')
      },   
        
      {                   
        description:"Ethereum Classic",
        acronym:"ETC",
        url_image:"https://wiki.trezor.io/images/Etc.png",
        mining_type: MiningType.find_by(acronym:'PoC')
      },
                
      {                   
        description:"Iota",
        acronym:"Iota",
        url_image:"https://images.cointelegraph.com/images/240_aHR0cHM6Ly9zMy5jb2ludGVsZWdyYXBoLmNvbS9zdG9yYWdlL3VwbG9hZHMvdmlldy82NDI0YmI1ZDg0YTIzMGEzM2JlY2NlY2IwYTRjNWQ2MC5wbmc=.png",
        mining_type: MiningType.all.sample
      },
        
      {                   
        description:"Ripple",
        acronym:"XRP",
        url_image:"https://www.comocomprarcriptomoedas.com/wp-content/uploads/2018/04/ripple-logo-xrp.png",
        mining_type: MiningType.all.sample
      },
        
      {                   
        description:"Dash",
        acronym:"Dash",
        url_image:"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8nZH5Mll1MCDckMBv_8ICRpHLApQcJe3I6YquAx7URHxMLBXg",
        mining_type: MiningType.all.sample
      }
    ]
             
  
  coins.each do |coin|
      Coin.find_or_create_by!(coin)
  
    end
  end
end

desc "Cadastro dos Tipos de Mineraçao"
task add_mining_types: :environment do
  show_spinner("Cadastrando Proof Miner...", "concluido") do
    mining_types = [
      {description:"Proof of Work", acronym:"PoW"},
      {description:"Proof of Stake", acronym: "PoS"},
      {description:"Proof of Capacity", acronym: "PoC"}
    ]
  
  mining_types.each do |mining_type|
      MiningType.find_or_create_by!(mining_type)
    end
  end
end
  

  private

  def show_spinner(msg_start, msg_end)
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end}")
  end
end
