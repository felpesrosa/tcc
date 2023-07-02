# ptcc
Repositório para controlar as versões do PTCC


## como rodar:
- instalar Java que tenha o projeto Loom
    instalar o SDKMan
        curl -s "https://get.sdkman.io" | bash 
        source "$HOME/.sdkman/bin/sdkman-init.sh"
        sdk version
    
    instalar a versão Java
        sdk install java 21.ea.23-open

    conferir instalação
        java --version

- instalar o Vegeta, ferramenta para disparo de requisições:
    curl -LO https://github.com/tsenart/vegeta/releases/download/v12.8.3/vegeta-12.8.3-linux-amd64.tar.gz
    tar -zxvf vegeta-12.8.3-linux-amd64.tar.gz
    sudo mv ./vegeta /usr/bin/vegeta
    vegeta --version

- rodar o programa ThreadedServer.Main
    na versão 21 do Java não precisa mais do --enable-preview no propath de execução

- mudar permissão dos .sh para conseguir executar
    chmod 751 _test-runner-v1.sh _test-runner-v2.sh _test-runner-v3.sh _test-runner-v4.sh
