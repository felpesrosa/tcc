# script para rodar os testes com vegeta

for i in $(seq 1 10)
do
    echo ""
    echo "->->->->->->->-> Execution: $i <-<-<-<-<-<-<-<-"
    echo ""

    # total de 10_000 requisições em 10s com PlatformThreads
    echo " $i º loop, PlatformThreads >" $(date)
    vegeta attack -duration=10s -rate=1000 -targets=1-Target_with_Platform_Threads.txt | vegeta report > ./results/withPlatformThreads_loop_$i.txt
    echo "fim $i º loop com PlatformThreads >" $(date)
    echo ""

    sleep 120s

    # total de 10_000 requisições em 10s com CachedThreads
    echo " $i º loop, CachedThreads >" $(date)
    vegeta attack -duration=10s -rate=1000 -targets=3-Target_with_Cached_Threads.txt | vegeta report > ./results/withCachedThreads_loop_$i.txt
    echo "fim $i º loop com CachedThreads >" $(date)
    echo ""

    sleep 120s

    # total de 10_000 requisições em 10s com SingleThread
    echo " $i º loop, SingleThread >" $(date)
    vegeta attack -duration=10s -rate=1000 -targets=2-Target_with_Single_Thread.txt | vegeta report > ./results/withSingleThread_loop_$i.txt
    echo "fim $i º loop com SingleThread >" $(date)
    echo ""

    sleep 120s

    # total de 10_000 requisições em 10s com VirtualThreads
    echo " $i º loop, VirtualThreads >" $(date)
    vegeta attack -duration=10s -rate=1000 -targets=4-Target_with_Virtual_Threads.txt | vegeta report > ./results/withVirtualThreads_loop_$i.txt
    echo "fim $i º loop com VirtualThreads >" $(date)

    sleep 120s

done

echo ">>>>>>>>>> fim <<<<<<<<<<"
