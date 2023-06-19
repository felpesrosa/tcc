# script para rodar os testes com vegeta

read -p "com VirtualThreads, começar? "

# primeiro Caso de Teste > executor do Tomcat com VirtualThreads
    echo "trocando server.xml do Tomcat para virtualThreads"
    sudo cp ~/univille/tcc/conf/tomcat/xmlconf/server.virtual.xml /opt/tomcat/conf/server.xml

    echo "subindo o servidor Tomcat"
    sudo systemctl start tomcat

    read -p "VisualVM com Monitor Sampler ativado?"

    sleep 3s

    for iCT1 in $(seq 1 5)
    do
        curl http://localhost:8080/Servlet/primeNumber?openCSVFile=true

        # total de 80_000 requisições em 10s com VirtualThreads
        echo " $iCT1 º loop, VirtualThreads >" $(date)
        echo " $iCT1 º loop, VirtualThreads >" $(date) >> ./runnerlog.txt
        vegeta attack -duration=10s -rate=8000 -targets=./targets/1_Targers_with_delay.txt | vegeta report > ./results/vt/virtualThreads_loop_$iCT1.txt
        echo "fim $iCT1 º loop com VirtualThreads >" $(date)
        echo "fim $iCT1 º loop com VirtualThreads >" $(date) >> ./runnerlog.txt
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
    sudo cp ~/univille/tcc/conf/tomcat/xmlconf/server.cached.xml /opt/tomcat/conf/server.xml

    echo "subindo o servidor Tomcat"
    sudo systemctl start tomcat

    read -p "VisualVM com Monitor Sampler ativado?"

    sleep 3s

    for iCT2 in $(seq 1 5)
    do
        curl http://localhost:8080/Servlet/primeNumber?openCSVFile=true

        # total de 80_000 requisições em 10s com CachedThreads
        echo " $iCT2 º loop, CachedThreads >" $(date)
        echo " $iCT2 º loop, CachedThreads >" $(date) >> ./runnerlog.txt
        vegeta attack -duration=10s -rate=8000 -targets=./targets/1_Targers_with_delay.txt | vegeta report > ./results/ct/cachedThreads_loop_$iCT2.txt
        echo "fim $iCT2 º loop com CachedThreads >" $(date)
        echo "fim $iCT2 º loop com CachedThreads >" $(date) >> ./runnerlog.txt
        echo ""

        curl http://localhost:8080/Servlet/primeNumber?closeCSVFile=true

        sleep 70s    
    done

    read -p "dados da VisualVM exportados?"
    echo "fim CT2"

echo "parando Tomcat"
sudo systemctl stop tomcat

# terceiro Caso de Teste > executor do Tomcat com PlatformThreads
    echo "trocando server.xml do Tomcat para PlatformThreads"
    sudo cp ~/univille/tcc/conf/tomcat/xmlconf/server.platform.xml /opt/tomcat/conf/server.xml

    echo "subindo o servidor Tomcat"
    sudo systemctl start tomcat

    read -p "VisualVM com Monitor Sampler ativado?"

    sleep 3s

    for iCT3 in $(seq 1 5)
    do
        curl http://localhost:8080/Servlet/primeNumber?openCSVFile=true

        # total de 80_000 requisições em 10s com PlatformThreads
        echo " $iCT3 º loop, PlatformThreads >" $(date)
        echo " $iCT3 º loop, PlatformThreads >" $(date) >> ./runnerlog.txt
        vegeta attack -duration=10s -rate=8000 -targets=./targets/1_Targers_with_delay.txt | vegeta report > ./results/pt/PlatformThreads_loop_$iCT3.txt
        echo "fim $iCT3 º loop com PlatformThreads >" $(date)
        echo "fim $iCT3 º loop com PlatformThreads >" $(date) >> ./runnerlog.txt
        echo ""

        curl http://localhost:8080/Servlet/primeNumber?closeCSVFile=true

        sleep 70s    
    done

    read -p "dados da VisualVM exportados?"
    echo "fim CT3"


echo "parando Tomcat"
sudo systemctl stop tomcat

# quarto Caso de Teste > executor original do Tomcat
    echo "colocando o server.xml original do Tomcat"
    sudo cp ~/univille/tcc/conf/tomcat/xmlconf/server.orignal.xml /opt/tomcat/conf/server.xml

    echo "subindo o servidor Tomcat"
    sudo systemctl start tomcat

    read -p "VisualVM com Monitor Sampler ativado?"

    sleep 3s

    for iCT4 in $(seq 1 5)
    do
        curl http://localhost:8080/Servlet/primeNumber?openCSVFile=true

        # total de 80_000 requisições em 10s com executor original do Tomcat
        echo " $iCT4 º loop,  executor do Tomcat >" $(date)
        echo " $iCT4 º loop,  executor do Tomcat >" $(date) >> ./runnerlog.txt
        vegeta attack -duration=10s -rate=8000 -targets=./targets/1_Targers_with_delay.txt | vegeta report > ./results/original/nio_loop_$iCT4.txt
        echo "fim $iCT4 º loop com  executor do Tomcat >" $(date)
        echo "fim $iCT4 º loop com  executor do Tomcat >" $(date) >> ./runnerlog.txt
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

