import com.bjpowernode.service.ActivitiesServer;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;

@ContextConfiguration("classpath:applicationContext.xml")
@RunWith(SpringJUnit4ClassRunner.class)
public class f3 {
    @Resource
    ActivitiesServer actService;

    @Test
    public void fun1(){

    }
}
