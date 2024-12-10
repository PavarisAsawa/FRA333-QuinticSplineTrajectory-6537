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
ทำการ Download Add ons ของ Robotics System Toolbox ใน Command Window ของ MATLAB
```cmd
matlab.addons.install('Robotics System Toolbox')
```

## **Feature**

ภายในของโปรแกรมจะประกอบด้วย
#### **B-Spline Function**
- **`BasisFunction.m`** : เพื่อทำการคำนวณ Basis Function ของสมการ B-Spline ที่เวลาใด ๆ โดยกำหนดจาก Knot
- **`BasisFunctionDerivative.m`** : ทำการคำนวณอนุพันธ์ลำดับที่ 1 ของ Basis Function

    ```matlab
    BasisFunction(i, d, t, knots)
    BasisFunctionDerivative(i, d, t, knots)
    ```
    - `i` : Control point ทั้งหมดโดยแต่ละจุดเป็น Matrix ขนาด [3 ; 1] *3 แถว 1 column*
    - `d` : degree ของ basis function
    - `knots` : Knot Vector ที่ใช้ในการสร้างสมการ
    - `t` : Basis function ที่ต้องการหา ณ เวลา t
    - โดยจะ return เป็นค่าของ Basis function ที่เวลา t

- **`KnotGenerator.m`** : สร้าง Clamped Knot เพื่อกำหนดการทำงานของ Basis Function
    ```matlab
    KnotGenerator(i, t_start, t_end, d)
    ```
    - `t_start` : เวลาที่เริ่มการทำงานของ Trajectory
    - `t_end` : เวลาที่สิ้นสุดการทำงานของ Trajectory
    - โดยจะ return ค่าออกมาเป็น Clamped Knot Vector ขนาด [1 ; (จำนวน Control Point + Degree +1)]

- **`plotBSplineBasis.m`** : พล็อตกราฟของ Basis Function เพื่อตรวจสอบค่าของ Basis Function ของแต่ละ Control Point ในแต่ละช่วงเวลา
    ```matlab
    knot = [0 0 0 0 1 2 3 3 3 3];  % ตัวอย่าง Knot Vector
    degree = 3;  % Degree ของ B-Spline
    plotBSplineBasis(knots, d)
    ```
    - โดยจะทำการแสดงค่ากราฟของ Basis Function ที่ช่วงเวลาต่าง ๆ 
    ![image](https://github.com/user-attachments/assets/66546c8d-70fe-4135-97b5-d5157f303486)

#### **UR5**
- **`UR5FowardKinematics.m`** : ทำการหาตำแหน่งปลายมือของ UR5
- **`UR5InverseKinematic.m`** : ทำการ Inverse Kinematic หาตำแหน่งของ Joint

    ```matlab
    UR5ForwardKinematics(ur5, q)
    UR5InverseKinematics(ur5, targetTranslation, q)
    ```
    - `ur5` : พารามิเตอร์หุ่นยนต์ ur5
    - `q` : Joint Configuration โดยเป็น multibody tree
    - `targetTranslation` : ตำแหน่ง Position ที่ต้องการหา Inverse Kinematic

#### **Trajectory Generator**
- **`checkIKForTrajectory.m`** : ทำการ IK ทุกจุดใน Trajectory เพื่อตรวจสอบว่า Trajectory นั้นเป็นจุดที่สามารถเคลื่อนที่ถึงได้โดยใช้ UR5 หรือไม้
    ```
    checkIKForTrajectory(ur5, trajectory, q)
    ```
    - `trajectory` : Trajectory ที่ถูกสร้างมา

- **`Task2JointTrajectoryMapper.m`** : ทำการแปลง Setpoint ของ Task Space เป็น Joint Space เพื่อควบคุม Joint ของหุ่นยนต์
    ```
    Task2JointTrajectoryMapper(ur5,trajectory,q)
    ```
    - โดยจะ return เป็นค่าของ Trajectory ของ Joint Configuration

- **`TrajectoryGenerator.m`** : สร้างวิถีโคจรที่พิกัดปลายมือ
    ```
    TrajectoryGenerator(i,t_use, d)
    ```
    - `t_use` เวลาที่ใช้ในการเคลื่อนที่ทั้งหมด
- **`ExecuteTrajectory.m`** : ทำการ Simulation การเคลื่อนที่ของหุ่นยนต์
    ```
    ExecuteTrajectory(ur5,i,t_use,d,q)
    ```

## Use Case
ตัวอย่างการใช้งานเพื่อสร้าง End Effector Trajectory โดยใช้ B-Spline Degree ที่ 5 โดยใช้ระยะเวลา 5 วินาทีในการเคลื่อนที่
```matlab
ur5 = loadrobot("universalUR5");
q = homeConfiguration(ur5);
initial_pos = tform2trvec(getTransform(ur5, q, 'tool0'));
control_points1 = [
                    initial_pos; % ตำแหน่งปัจจุบัน
                    0.0, 0.2, 0.0;
                    0.1, 0.5, 0.3;
                    0.2, 0.2, 0.2;
                    0.2, 0.1, 0.3;
                    0.1, 0.8, 0.2;
                    0.3, 0.3, 0.1;
                    0.2, 0.3, 0.5;
                ];
ExecuteTrajectory(ur5,control_points1,5,5,q);
```


https://github.com/user-attachments/assets/a64513cf-eeef-4240-9ea0-6f503cd16ad3






   	
