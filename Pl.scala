import util.control.Breaks._
import java.io._
import scala.io.Source

object Pl{
    var init_board=Array(" "," "," "," "," "," "," "," "," "," ")
    var p="O"
    var check=true
    var cnt=0
    def main(args:Array[String]): Unit ={

        val valueText=new Array[Int](9)

        //val (start,end)=Pair(1,9)
        //val rnd=new scala.util.Random()
        val x=scala.util.Random.shuffle(List(1,2,3,4,5,6,7,8,9))
        println(x)
        val arr_x=x.toArray

        println("\n====List====\n")
        for (i<-0 to 8) {
            valueText(i) = arr_x(i)//start + rnd.nextInt((end - start) + 1)
            println("Move ["+(i+1)+"]="+valueText(i))
        }
        Generate(valueText)
        ReadFile()
        drawBoard()
    }
    def Generate(valueText:Array[Int]){

        val file=new File("test.txt")
        val bw=new BufferedWriter(new FileWriter(file))
        for(i<-0 to 8){
          bw.write(valueText(i).toString())
          bw.newLine()
        }
        bw.close()
    }

    def ReadFile(): Unit ={
        var finish=0
        var count=0
        println("\n====Read====\n")
        val file="test.txt"
        for(line<-Source.fromFile(file).getLines()){
            //println(line)
            var x =line.toInt
            if (finish==0){
                if(count%2==0){
                    println("A : "+line)
                    p="O"
                    init_board(x)=p
                }
                else{
                    println("B : "+line)
                    p="X"
                    init_board(x)=p
                }
            }
          finish=checkWin()
          count+=1
        }
      checkState(finish)
    }

    def drawBoard(): Unit = {
      println("\n====Board====\n")
      println("---------------")
      println("| "+init_board(1)+" │ "+init_board(2)+" │ "+init_board(3)+" │ ")
      println("---------------")
      println("| "+init_board(4)+" │ "+init_board(5)+" │ "+init_board(6)+" │")
      println("---------------")
      println("| "+init_board(7)+" │ "+init_board(8)+" │ "+init_board(9)+" │")
      println("---------------")
    }

    def checkWin():Int={
        if(init_board(1)==init_board(2) && init_board(2)==init_board(3) && init_board(1)!=" "){
          return 1
        }
        else if (init_board(4) == init_board(5) && init_board(5) == init_board(6) && init_board(4) != " ") {
          return 1
        }
        else if (init_board(7) == init_board(8) && init_board(8) == init_board(9) &&init_board(7) != " ") {
          return 1
        }
        else if (init_board(1) == init_board(4) && init_board(4) == init_board(7) &&init_board(1) != " ") {
          return 1
        }
        else if (init_board(2) == init_board(5) && init_board(5) == init_board(8) &&init_board(2) != " ") {
          return 1
        }
        else if (init_board(3) == init_board(6) && init_board(6) == init_board(9) && init_board(3) != " ") {
          return 1
        }
        else if (init_board(1) == init_board(5) && init_board(5) == init_board(9) && init_board(1) != " ") {
          return 1
        }
        else if (init_board(3) == init_board(5) && init_board(5) == init_board(7) && init_board(3) != " ") {
          return 1
        }
        else if (init_board(1) != " " && init_board(2) != " " && init_board(3) != " " && init_board(4) != " " && init_board(5) != " " && init_board(6) != " " && init_board(7) != " " && init_board(8) != " " && init_board(9) != " ") {
          return -1
        }
        else {
          return 0
        }
    }

    def checkState(finish:Int): Unit ={
        println("\n====Result====")
        if(finish == -1){
          println("\nDraw")
        }
        else if (finish == 1){
            if(p=="O"){
              println("\nA Win\n")
            }
            else{
              println("\nB Win\n")
            }
        }
        else {
          println("\n")
        }
    }
}
