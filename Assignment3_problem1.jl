using DataFrames
t=1;
w=0;
th=0;
f=0;
table = DataFrame(Time=["08:00-08:30","08:30-09:00","09:00-09:30","09:30-10:00","10:00-10:30"],Monday=["empty","empty","empty","empty","empty"],Tuesday=["empty","empty","empty","empty","empty"],Wednesday=["empty","empty","empty","empty","empty"],Thursday=["empty","empty","empty","empty","empty"],Friday=["empty","empty","empty","empty","empty"])
course_name="empty";
preRstatus="empty";
course_count=0;
cstable= DataFrame(courseName=[],prerequisite=[],count=[])
prs = DataFrame(dayOfTheWeek=["Monday","Tuesday","Wednesday","Thursday","Friday"],prerequisiteStatues=[false,false,false,false,false])
function registerCourse()

print("Enter the numbers of courses you want to enter")
numberString = readline()
number= parse(Int,numberString)
for e in 1:number
global course_count=0
print("Enter course name")
global course_name=readline()
print("Is course prerequiste? ")
global preRstatus = readline()
push!(cstable,(course_name,preRstatus,course_count))
end
end

###############################################
function shiftCourseThursday(course,pr)
    for e in 1:size(table)[1]
    if table[5][e]== "empty" && prs[2][4]!= true && pr=="yes" && cstable[3][e]==0
        table[5][e]=course
        prs[2][4]=true


 end
    end
end


###############################################
function shiftCourseWednesday(course,pr)
    for e in 1:size(table)[1]

    if table[4][e]== "empty" && prs[2][3]!= true && pr=="yes" && cstable[3][e]==0
        table[4][e]=course
        prs[2][3]=true
        cstable[3][e]= 1
    elseif pr=="no" && table[4][e]=="empty" && cstable[3][e]==0
            table[4][e]=course
             cstable[3][e]=1
        elseif table[4][e]== "empty" && prs[2][3]== true && pr=="yes"
            shiftCourseThursday(cstable[1][e],cstable[2][e])
 end
    end
end

#################################################
function shiftCourseTuesday(course,pr)
    for e in 1:size(table)[1]
    if table[3][e]== "empty" && prs[2][2]!= true && pr=="yes"
        table[3][e]=course
        prs[2][2]=true
    elseif pr=="no" && table[3][e]=="empty"
            table[3][e]=course

 end
    end
end

function start_scheduling()
    td = false
    t=1;
      for e in 1:size(cstable)[1]
          print(e)
          if e < 5
           if cstable[2][e]=="yes" && table[2][e]=="empty" && prs[2][1]!=true && cstable[3][e]==0
               table[2][e]= cstable[1][e]
               prs[2][1]=true
               cstable[3][e]=1
           elseif cstable[2][e]=="no" && table[2][e]=="empty" && cstable[3][e]==0
               table[2][e]=cstable[1][e]
               cstable[3][e]=1
           elseif  cstable[2][e]=="yes" && prs[2][1]==true
               shiftCourseTuesday(cstable[1][e],cstable[2][e])
                end
            if cstable[2][e]=="no" && table[2][e]=="empty" && cstable[3][e]==0
                table[2][e]=cstable[1][e]
                cstable[3][e]=1
            end

            end

            if e==4
                td=true
            end
            #####################################
            if td && e > 4
                print("E is $e")
             if cstable[2][e]=="yes" && table[3][t]=="empty" && prs[2][2]!=true && cstable[3][e]==0
                 table[3][t]= cstable[1][e]
                 prs[2][2]=true
                 cstable[3][e]=1
             elseif cstable[2][e]=="no" && table[2][t]=="empty" && cstable[3][e]==0
                 table[3][t]=cstable[1][e]
                 cstable[3][e]=1
             elseif  cstable[2][e]=="yes" && prs[2][2]==true
                 shiftCourseWednesday(cstable[1][e],cstable[2][e])
                  end
                  t+=1
                  print("this is t $t")
              end


        end  #end first for loop
end# end of function


function addCourseMonday()
    for e in 1:size(cstable)[1]
        if e < 5
    if table[1][e]== "empty"
        if cstable[2][e]=="yes" && prs[2][e]!=true && prs[1][e]=="Monday"
     table[1][e] = cstable[1][e]
     prs[2][e]=true
 elseif cstable[2][e]=="no"
     table[1][e] = cstable[1][e]
elseif  cstable[2][e]=="yes" && prs[2][1]==true
    shiftCourseTuesday(cstable[1][e],cstable[2][e])

 end
    end

end
end # end of loop
end#end of function

###############################################

registerCourse();
