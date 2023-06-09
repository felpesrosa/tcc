# script para rodar os testes com vegeta

read -p "com VirtualThreads, começar? "

# primeiro Caso de Teste > executor do Tomcat com VirtualThreads
    echo "trocando server.xml do Tomcat para virtualThreads"
    sudo cp ~/Downloads/30.06.2023/tcc/conf/tomcat/xmlconf/server.virtual.xml /opt/tomcat/conf/server.xml

    echo "subindo o servidor Tomcat"
    sudo systemctl start tomcat

    sleep 5s

    read -p "VisualVM com Monitor Sampler ativado?"

    sleep 3s

    for iCT1 in $(seq 1 7)
    do
        curl http://localhost:8080/Servlet/primeNumber?openCSVFile=true

        # total de 80_000 requisições em 10s com VirtualThreads
        echo "$iCT1 º loop, VirtualThreads >" $(date)
        echo "$iCT1 º loop, VirtualThreads >" $(date) >> ./runnerlog.txt
        vegeta attack -connections=500000 -timeout=90s -duration=10s -rate=5000 -targets=./targets/1_Targers_with_delay.txt | vegeta report > ./results/vt/virtualThreads_loop_$iCT1.txt
        echo "$iCT1 º loop com VirtualThreads >" $(date)
        echo "$iCT1 º loop com VirtualThreads >" $(date) >> ./runnerlog.txt
        echo ""

        curl http://localhost:8080/Servlet/primeNumber?closeCSVFile=true

        sleep 70s    
    done

    read -p "dados da VisualVM exportados?"
    echo "fim CT1"

echo "parando Tomcat"
sudo systemctl stop tomcat

# segundo Caso de Teste > executor do Tomcat com CachedThreads
    echo "trocando server.xml do Tomcat para CachedThreads"
    sudo cp ~/Downloads/30.06.2023/tcc/conf/tomcat/xmlconf/server.cached.xml /opt/tomcat/conf/server.xml

    echo "subindo o servidor Tomcat"
    sudo systemctl start tomcat

    read -p "VisualVM com Monitor Sampler ativado?"

    sleep 3s

    for iCT2 in $(seq 1 7)
    do
        curl http://localhost:8080/Servlet/primeNumber?openCSVFile=true

        # total de 80_000 requisições em 10s com CachedThreads
        echo "$iCT2 º loop, CachedThreads >" $(date)
        echo "$iCT2 º loop, CachedThreads >" $(date) >> ./runnerlog.txt
        vegeta attack -connections=500000 -timeout=90s -duration=10s -rate=5000 -targets=./targets/1_Targers_with_delay.txt | vegeta report > ./results/ct/cachedThreads_loop_$iCT2.txt
        echo "$iCT2 º loop com CachedThreads >" $(date)
        echo "$iCT2 º loop com CachedThreads >" $(date) >> ./runnerlog.txt
        echo ""

        curl http://localhost:8080/Servlet/primeNumber?closeCSVFile=true

        sleep 70s    
    done

    read -p "dados da VisualVM exportados?"
    echo "fim CT2"

echo "parando Tomcat"
sudo systemctl stop tomcat

# quarto Caso de Teste > executor original do Tomcat
    echo "colocando o server.xml original do Tomcat"
    sudo cp ~/Downloads/30.06.2023/tcc/conf/tomcat/xmlconf/server.original.xml /opt/tomcat/conf/server.xml

    echo "subindo o servidor Tomcat"
    sudo systemctl start tomcat

    read -p "VisualVM com Monitor Sampler ativado?"

    sleep 3s

    for iCT4 in $(seq 1 7)
    do
        curl http://localhost:8080/Servlet/primeNumber?openCSVFile=true

        # total de 80_000 requisições em 10s com executor original do Tomcat
        echo "$iCT4 º loop,  executor do Tomcat >" $(date)
        echo "$iCT4 º loop,  executor do Tomcat >" $(date) >> ./runnerlog.txt
        vegeta attack -connections=500000 -timeout=90s -duration=10s -rate=5000 -targets=./targets/1_Targers_with_delay.txt | vegeta report > ./results/original/nio_loop_$iCT4.txt
        echo "$iCT4 º loop com  executor do Tomcat >" $(date)
        echo "$iCT4 º loop com  executor do Tomcat >" $(date) >> ./runnerlog.txt
        echo ""

        curl http://localhost:8080/Servlet/primeNumber?closeCSVFile=true

        sleep 70s    
    done

    read -p "dados da VisualVM exportados?"
    echo "fim CT3"
    
    
echo "parando Tomcat"
sudo systemctl stop tomcat

echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> fim "
read -p "entra para finalizar"

