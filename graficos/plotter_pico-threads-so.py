import matplotlib.pyplot as grafico
import csv
  
xvt = []
yvt = []
xct = []
yct = []
xtomcat = []
ytomcat = []
  
with open(
    'C:\\Users\\felip\\Downloads\\30.06.2023\\tcc\\_com_max-memory-java_e_flag_server\\tcc\\visualvmresults\\_latencia-5-ultimas-execucoes.csv','r'
    ) as csvfile:
    lines = csv.reader(csvfile, delimiter=';')
    for row in lines:
        if row[0] == 'Virtual Threads':
            xvt.append(row[1])
            yvt.append(float(row[5]))

        
        if row[0] == 'Cached Threads':
            xct.append(row[1])
            yct.append(float(row[5]))

        
        if row[0] == 'Tomcat Threads':
            xtomcat.append(row[1])
            ytomcat.append(float(row[5]))

grafico.rc('lines', linewidth=2.0)
fig, ax = grafico.subplots()
grafico.axis(ymin=0,ymax=1000)
# grafico.yticks(range(100.0,105.0,))
grafico.grid(True)

line1 = ax.plot(xvt, yvt, label='Virtual Threads' ,linestyle="--",marker='^')
line2 = ax.plot(xct, yct, label='Cached Threads',linestyle="--",marker='o')
line3 = ax.plot(xtomcat, ytomcat, label='Tomcat Threads',linestyle="--",marker='X')

ax.legend(handlelength=2)

grafico.ylabel("Nº de Threads")
grafico.xlabel("Execução")
grafico.title('Pico de uso de threads por execução')

grafico.show()
