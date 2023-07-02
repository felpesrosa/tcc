## TCC, anotações

### Links
- Instalar JDK com <https://sdkman.io/usage> na versão 21
        sdk install java
        
- Instalar o Tomcat na versão 11: <https://tomcat.apache.org/download-11.cgi>
- Ferramenta de disparo de requisições: <https://github.com/tsenart/vegeta>
- VisualVM: <https://visualvm.github.io/>

### Organização do repositório:
- os testes foram executados a partir do script [/conf/vegeta/_test-runner.sh](./conf/vegeta/_test-runner.sh)
- nele, a ferramenta de disparo de requisições executa a cada segundo as 5000 primeiras linhas do arquivo [/conf/vegeta/targets](./conf/vegeta/targets/1_Targers_with_delay.txt)
- a cada execução, a ferramenta vegeta gera um relatório que fica salvo em [/conf/vegeta/results](./conf/vegeta/results/)
- para cada tipo de thread, um arquivo server.xml é utilizado no Tomcat, referenciando o criador de thread correspondente [/conf/tomcat/xmlconf/](./conf/tomcat/xmlconf/) 
- as classes geradoras de thread, utilizadas pelo Tomcat estão no [/conf/tomcat/jars](./conf/tomcat/jars/)
- a servlet que é executada fica em [/servlet](./servlet/)
- os códigos Python que geraram os gráficos ficam em [/graficos](./graficos/)
- no final de cada execução, os dados exportados da VisualVM ficaram em [/visualvmresults](./visualvmresults/) e para gerar os dados do TCC foram criados uns arquivos intermediários que contém apenas as requisições válidas, como o [_latencia-5-ultimas-execucoes.csv](./visualvmresults/_latencia-5-ultimas-execucoes.csv)

        
### Compilar a Servlet
        cd /servlet/
        javac -d web/WEB-INF/classes/ -cp /opt/tomcat/lib/\* src/*.java
        jar cvf Servlet.war -C web .
        sudo cp Servlet.war /opt/tomcat/webapps/

### Conseguir abrir o arquivo no /tmp
        cd /tmp/reports
        sudo chmod -R 777 ./

### Manipular o Tomcat
        sudo systemctl start tomcat
        sudo systemctl stop tomcat
        sudo systemctl status tomcat


### Exemplos de URL do Tomcat
        // criar o arquivo .CSV
        curl http://localhost:8080/Servlet/primeNumber?openCSVFile=true
        

        // testar um número primo sem delay
        curl http://localhost:8080/Servlet/primeNumber?numberToCheck=6696983
        

        // testar um número primo com delay
        curl http://localhost:8080/Servlet/primeNumber?numberToCheck=6696983&delayedExecution=true
        

        // fechar o arquivo .CSV
        curl http://localhost:8080/Servlet/primeNumber?openCSVFile=true
        
