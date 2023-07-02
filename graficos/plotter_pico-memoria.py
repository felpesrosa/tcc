# import numpy as np
# import matplotlib.pyplot as plt

# # creating the dataset
# data = {'Virtual':20,
#         'Cached':15,
#         'Tomcat':30}
# courses = list(data.keys())
# values = list(data.values())
  
# # fig = plt.figure(figsize = (10, 5))
 
# # creating the bar plot
# # plt.bar(courses, values, color ='maroon',
# #         width = 0.4)

# plt.bar(courses, values,width = 0.4)
 
# plt.xlabel("Tipo de Thread")
# plt.ylabel("Latência em Milisegundos")
# plt.title("Média de Latência")
# plt.show()

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
            yvt.append(float(row[4])/1000000)

        
        if row[0] == 'Cached Threads':
            xct.append(row[1])
            yct.append(float(row[4])/1000000)

        
        if row[0] == 'Tomcat Threads':
            xtomcat.append(row[1])
            ytomcat.append(float(row[4])/1000000)

grafico.rc('lines', linewidth=2.0)
fig, ax = grafico.subplots()
# grafico.axis(ymin=0,ymax=1300)
# grafico.yticks(range(100.0,105.0,))
grafico.grid(True)

line1 = ax.plot(xvt, yvt, label='Virtual Threads' ,linestyle="--",marker='^')
line2 = ax.plot(xct, yct, label='Cached Threads',linestyle="--",marker='o')
line3 = ax.plot(xtomcat, ytomcat, label='Tomcat Threads',linestyle="--",marker='X')

ax.legend(handlelength=2)

grafico.ylabel("Utilização de memória (MB)")
grafico.xlabel("Execução")
grafico.title('Pico de Consumo de Memória por execução (MB)')

grafico.show()


# Display the values of each point
# for i in range(len(xvt)):
#     if i % 2 != 0:
#         ax.text(xvt[i], yvt[i], str(yvt[i]), ha='center', va='top')
# for i in range(len(xct)):
#     if i % 2 == 0:
#         ax.text(xct[i], yct[i], str(yct[i]), ha='center', va='top')
# for i in range(len(xtomcat)):    
#     if i % 2 != 0:
#         ax.text(xtomcat[i], ytomcat[i], str(ytomcat[i]), ha='center', va='top')
