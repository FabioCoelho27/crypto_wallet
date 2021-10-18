namespace :dev do
  desc "Configurando o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando DB...") do 
        %x(rails db:drop)
      end 
      show_spinner("Criando DB...") do
        %x(rails db:create)
      end 
      show_spinner("Migrando DB...") do 
        %x(rails db:migrate)
      end 
      %x(rails dev:add_mining_types)
      %x(rails dev:add_coins)
      

    else 
      puts "Você não está em ambiente de desenvolvimento..."
    end
  end

  desc "Cadastrando as moedas"
  task add_coins: :environment do
    show_spinner("Cadastrando Moedas...")
      coins = [
                {
                  description: "Bitcoin",
                  acronym: "BTC",
                  url_image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSxR8uR17ReFGuwv5MnAySf3lUPO0OECWztVT4AKxGZBhf6DlPfmoFQFhao32X5WO0O0ZI&usqp=CAU",
                  mining_type: MiningType.find_by(acronym: 'PoW')
                },
                { 
                  description: "Ethereum",
                  acronym: "ETH",
                  url_image: "https://www.pngitem.com/pimgs/m/124-1245793_ethereum-eth-icon-ethereum-png-transparent-png.png",
                  mining_type: MiningType.all.sample
                },
                { 
                  description: "Doge",
                  acronym: "DGE",
                  url_image: "https://www.vippng.com/png/detail/2-21703_doge-0-00000044-dogecoin.png",
                  mining_type: MiningType.all.sample 
                },
                { 
                  description: "Binance",
                  acronym: "BNB",
                  url_image: "https://cdn.pixabay.com/photo/2021/04/30/16/47/bnb-6219388_640.png",
                  mining_type: MiningType.all.sample 
                }
      ]
      coins.each do |coin|
        sleep(1)
        Coin.find_or_create_by!(coin)
      end
  end

  desc "Cadastro tipos de mineração"
   task add_mining_types: :environment do 
    show_spinner("Cadastrando tipos de mineração...")
     mining_types = [
       {description: "Proof of Work", acronym: "PoW"},
       {description: "Proof of Stake", acronym: "PoS"},
       {description: "Proof of Capacity", acronym: "PoC"}
      ]
      mining_types.each do |mining_type|
        MiningType.find_or_create_by!(mining_type)
      end
   end

  private

  def show_spinner(msg_start, msg_end = "Concluído!")
    spinner = TTY::Spinner.new("[:spinner]#{msg_start}")
    spinner.auto_spin
    %x(rails db:seed)
    spinner.success("(#{msg_end})")
  end
end