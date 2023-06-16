# script para rodar os testes com vegeta

# primeiro Caso de Teste > executor do Tomcat com VirtualThreads
sudo cp asdsad /opt/tomcat/conf/server.xml

echo ""
echo "->->->->->-> VirtualThreads, execution: $i <-<-<-<-<-<-"
echo ""

sleep 5s
for i in $(seq 1 7)
do
    curl http://localhost:8080/Servlet/primeNumber?openCSVFile=true

    # total de 10_000 requisições em 10s com PlatformThreads
    echo " $i º loop, VirtualThreads >" $(date)
    vegeta attack -duration=30s -rate=1000 -targets=./targets/1_Targers_with_delay.txt | vegeta report > ./results/vt/virtualThreads_loop_$i.txt
    echo "fim $i º loop com VirtualThreads >" $(date)
    echo ""

    curl http://localhost:8080/Servlet/primeNumber?closeCSVFile=true

    sleep 90s    
done

echo ">>>>>>>>>> fim <<<<<<<<<<"
