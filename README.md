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


## **B Spline Equation**
### B-Spline Formula
โดยการหา Trajectory จาก B-Spline Basis Function จะหาได้จากสมการดังนี้

$$
P(t) = \sum_{i=0}^{N} N_{i,k}(t) \cdot P_i
$$

Where:
- $ P(t) $ คือจุดบนเส้นโค้ง B-Spline ที่เวลา t
- $ N_{i,k}(t) $ คือ Basis Function ของ B-Spline ซึ่งขึ้นกับ Degree (k) และ Knot Vector
- $ P_i $ Control Points ที่กำหนดรูปทรงของเส้นโค้ง

### B-Spline Basis Function
เป็นฟังก์ชันที่กำหนดอิทธิพลของ Control Points ต่อเส้นโค้งในแต่ละช่วง โดย Basis Functions ของ B-Spline สามารถคำนวณได้โดยใช้สมการแบบ Recursive ตามลำดับของ Degree ของ B-Spline จะสามารถหหาได้ดังนี้

$$
N_{i,0} =
\begin{array}{ll}
1 & \text{if } u_i \leq t < u_{i+1} \\
0 & \text{otherwise}
\end{array}
$$

โดยสำหรับ Basis Function สำหรับ Degree ที่สูงขึ้นสามารถคำนวณได้จากสมการแบบ Recursive

$$
N_{i,k}(t)=\frac{t-u_i}{u_{i+k}-u_i}N_{i,k-1}(t)+\frac{u_{i+k+1}-t}{u_{i+k+1}-u_{i+1}}N_{i+1,k-1}(t)
$$
   	
- $u_i$ คือ Knot Value ใน Knot Vector
- $t$ คือ เวลาใด ๆ 
- $i$ คือ จุด Control Point ที่จุด $i$
- $k$ คือ Degree ของ B-Spline

## **Knot Vector**
เป็นลำดับของค่าที่ควบคุมช่วงและการเปลี่ยนแปลงของเส้นโค้ง B-Spline โดยการตั้งค่า Knot Vector จะกำหนดลักษณะของเส้นโค้งว่ามีความต่อเนื่องอย่างไรและมีลักษณะการเปลี่ยนทิศทางอย่างไร เช่น 

```
knot = [0 0 0 1  2 3 4 4 4];
degree = 2;
plotBSplineBasis(knot, degree);
```

โดยจำนวน Knot Value จะมีจำนวนเท่ากับ Control Point + Degree + 1 เสมอ
ซึ่งจะได้ผลดังภาพ
![untitled1](https://github.com/user-attachments/assets/7c2da2d0-9ac7-4765-9c27-9a67b651d724)

 มีความหมายว่า Control Point แรกจะมีผลในช่วงเวลาที่ 0 ถึง 1 เท่านั้น Control Point ที่ 2 จะมีผลคั้งแต่วินาทีที่ 0 ถึงวินาที่ที่ 2 และเปลี่ยนแปลงตามลำดับโดยทำงานเป็น Piecewise Function

## **ผลการทดสอบ**
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


ตัวอย่างการใช้งานเพื่อสร้าง End Effector Trajectory โดยใช้ B-Spline Degree ที่ 1 โดยใช้ระยะเวลา 5 วินาทีในการเคลื่อนที่
```matlab
ur5 = loadrobot("universalUR5");
q = homeConfiguration(ur5);
initial_pos = tform2trvec(getTransform(ur5, q, 'tool0'));
control_points2 = [
    initial_pos; % ตำแหน่งปัจจุบัน
    0.1, 0.2, 0.0;
    0.2, 0.5, 0.4;
    0.0, 0.8, 0.1;
    0.2, 0.2, 0.5;
];
ExecuteTrajectory(ur5,control_points2,5,1,q);
```
https://github.com/user-attachments/assets/05b8a2b0-055e-480d-a92c-50abf38cbe0c

#### **More Exmaple** : https://drive.google.com/drive/u/3/folders/1NbhBEOeg3ysZSrKFE5f1FbJwbUL8dYJg

## **สรุปและวิเคราะห์ผลการทดลอง**
จากการทดสอบการสร้าง Trajectory พบว่าสามารถสร้างสมการ Trajectory จาก B-Spline ใน Degree ต่าง ๆ ได้โดยเมื่อ Degree ของสมการสูงขึ้นจะเห็นว่าการเคลื่อนที่นั้น
จะเป็นเส้นโค้งเข้าสู่ Control Points แทนที่เป็น โดยเมื่อ Degree ของสมการเท่ากับ 1 จะส่งผลให้มีการเคลื่อนที่เป็นเส้นตรงเข้าสู่ Control Points ในทุก ๆ จุดทำให้มีการเปลี่ยนแปลง
ฉับพลันของความเร็วและความเร่งตาม Degree ของสมการ ทำให้ Trajectory อาจจะยังไม่เหมาะสมกับการใช้งาน

โดยในการควลคุมตำแหน่งของ Trajectory ของ B Spline เพียงอย่างเดียวนั้นอาจจะมีปัญหาในเรื่องของการจุด setpoint หลัง ๆ ได้เนื่องจากจากการใช้ Order ที่สูงขึ้น
จะเห็นได้ว่า setpoint นั้นจะมีระยะห่างกันที่มากขึ้นทำให้การเคลื่อนที่มีความต่อเนื่องลดลง โดยสามารถแก้ปัญหาได้โดยการลด dt หรือลดเวลาในการคำนวณใน
Discrete Time Domain หรือทำการใช้ Velocity/Acceleration เพิ่มเติมเพื่อควบคุมให้การเคลื่อนที่


## **Refference**
**[1]** Xu, Y., Liu, Y., Liu, X., Zhao, Y., Li, P., & Xu, P. (2024). Trajectory generation method for serial robots in hybrid space operations. Actuators, 13(3), 108.

**[2]** Gasparetto, A., Boscariol, P., Lanzutti, A., & Vidoni, R. (2012). Trajectory planning in robotics. Mathematics in Computer Science, 6, 269–279.

**[3]** Li, W., Tan, M., Wang, L., & Wang, Q. (2020). A cubic spline method combing improved particle swarm optimization for robot path planning in dynamic uncertain environment. International Journal of Advanced Robotic Systems, 17(1), 1729881419891661.

**[4]** Kebria, P. M., Al-Wais, S., Abdi, H., & Nahavandi, S. (2016, October). Kinematic and dynamic modelling of UR5 manipulator. In 2016 IEEE international conference on systems, man, and cybernetics (SMC) (pp. 004229-004234). IEEE. 

**[5]** Wen, Z., Liu, F., Dou, X., Chen, J., & Zhou, D. (2022, December). Research on Kinematics Analysis and Trajectory Planning of UR5 Robot. In Journal of Physics: Conference Series (Vol. 2396, No. 1, p. 012046). IOP Publishing.

**[6]** Yang, T., Tian, Y., Wang, Q., Wang, Y., Jiang, L., & Li, G. (2023, December). Kinematics Analysis and Trajectory Planning of UR5 Robot. In 2023 2nd International Conference on Automation, Robotics and Computer Engineering (ICARCE) (pp. 1-4). IEEE.
