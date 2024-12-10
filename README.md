# **B-Spline End-Effector Trajectory**
โปรเจ็คนี้จัดทำเพื่อสร้างแนววิถีโคจรในการเคลื่อนที่ของหุ่นยนต์ เมื่อมีจุดควบคุมหลายจุดในวิถีโคจร โดยสร้างวิถีโคจรที่ตำแหน่งปลายมือ (*End-Effector*) ของหุ่นยนต์โดยใช้สมการของ **`B-Spline`** ในการกำหนด Via Points หลาย ๆ ตำแหน่งในวิถีโคจร

โปรเจ็คนี้เป็นส่วนหนึ่งของรายวิชา FRA333 : Kinematics of Robotics System

## **วัตถุประสงค์**
1. เพื่อพัฒนาเส้นทางการเคลื่อนที่ของ End Effector โดยสามารถเคลื่อนที่ผ่านจุดควบคุมของหุ่นยนต์ UR5 
2. สร้าง Trajectory generator ที่สามารถกำหนดตำแหน่งของ End Effector หุ่นยนต์ UR5 ได้
3. ประยุกต์การใช้ความรู้พื้นฐานทางจลนศาสตร์เพื่อการใช้งานกับหุ่นยนต์ UR5

## **ขอบเขต**
1.	ขอบเขตในการสร้างวิถีโคจร
    - สามารถสร้างวิถีโคจรที่ End Effector แบบ Quintic spline โดยใช้เฉพาะการ Knot Vector แบบ Clamped Knot เพื่อควบคุมการเคลื่อนที่ตามจุดควบคุม

    -  หุ่นยนต์ UR5 สามารถเคลื่อนที่ได้ตามตำแหน่งทุกจุดใน Trajectory
    - สร้างวิถีโคจรโดยใช้การวิเคราะห์ทางจลนศาสตร์เท่านั้น
    -	ควบคุมและสร้าง Trajectory เฉพาะตำแหน่งของ End Effector เท่านั้น
2. ขอบเขตในการสร้างแบบจำลองของหุ่นยนต์
    - 	การจำลองการทำงานของหุ่นยนต์ จะใช้โปรแกรม MATLAB เพื่อการแสดงผลเท่านั้น
    - สามารถแสดงผล Control Points , Trajectory และแสดงการเคลื่อนที่ของหุ่นยนต์ UR5 ตาม Trajectory ได้
3.	ใช้หุ่นยนต์ UR5 เป็นหุ่นยนต์ที่ใช้ในการสร้างวิถีโคจรและการจำลอง

## Getting Start
ทำการ Clone git ของ Reposity หรือ Dowload ไฟล์ภายใน Repository
```cmd
git clone https://github.com/PavarisAsawa/FRA333-QuinticSplineTrajectory-6537.git
```
ภายในของโปรแกรมจะประกอบด้วย
### **B-Spline Function**
- **`BasisFunction.m`** : เพื่อทำการคำนวณ Basis Function ของสมการ B-Spline ที่เวลาใด ๆ โดยกำหนดจาก Knot
- **`BasisFunctionDerivative.m`** : ทำการคำนวณอนุพันธ์ลำดับที่ 1 ของ Basis Function
- **`KnotGenerator.m`** : สร้าง Clamped Knot เพื่อกำหนดการทำงานของ Basis Function
- **`plotBSplineBasis.m`** : พล็อตกราฟของ Basis Function เพื่อตรวจสอบค่าของ Basis Function ของแต่ละ Control Point ในแต่ละช่วงเวลา
### **UR5**
- **`UR5FowardKinematics.m`** : ทำการหาตำแหน่งปลายมือของ UR5
- **`UR5InverseKinematic.m`** : ทำการ Inverse Kinematic หาตำแหน่งของ Joint

### **Trajectory Generator**
- **`checkIKForTrajectory.m`** : ทำการ IK ทุกจุดใน Trajectory เพื่อตรวจสอบว่า Trajectory นั้นเป็นจุดที่สามารถเคลื่อนที่ถึงได้โดยใช้ UR5 หรือไม้
- **`Task2JointTrajectoryMapper.m`** : ทำการแปลง Setpoint ของ Task Space เป็น Joint Space เพื่อควบคุม Joint ของหุ่นยนต์
- **`TrajectoryGenerator.m`** : สร้างวิถีโคจรที่พิกัดปลายมือ
- **`ExecuteTrajectory.m`** : ทำการ Simulation การเคลื่อนที่ของหุ่นยนต์

## Input ของระบบ

   	
