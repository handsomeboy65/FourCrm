import com.bjpowernode.pojo.Dept;
import com.bjpowernode.pojo.Value;
import com.bjpowernode.service.DeptService;
import com.bjpowernode.service.ValueService;
import com.bjpowernode.utils.UUIDUtil;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;
import java.util.List;

@ContextConfiguration("classpath:applicationContext.xml")
@RunWith(SpringJUnit4ClassRunner.class)
public class f2 {
    @Resource
    DeptService deptService;

    @Test
    public void fun1(){
        Dept dept = new Dept(UUIDUtil.getUUID(),"1234","22222","22222","111111","18888888");
        deptService.add(dept);
    }

    @Test
    public void fun2(){

        List<Dept> all = deptService.getALL();
        for (Dept dept : all) {
            System.out.println(dept);
        }
    }

    @Test
    public void fun3(){

        Dept dept = deptService.getOne("b1cbbc24acd34966bb931266240605c7");
        System.out.println(dept);
    }

    @Test
    public void fun4(){
        Dept dept = new Dept("b1cbbc24acd34966bb931266240605c7","1234","33333","3333","333333","18888888");
        deptService.update(dept);

    }

    @Test
    public void fun5(){
        int i = deptService.delete("b1cbbc24acd34966bb931266240605c7");

    }


}
