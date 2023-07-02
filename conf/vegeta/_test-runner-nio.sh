# script para rodar os testes com vegeta

read -p "com VirtualThreads, começar? "

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

