import com.bjpowernode.mapper.TypeMapper;
import com.bjpowernode.mapper.UserMapper;
import com.bjpowernode.pojo.Type;
import com.bjpowernode.pojo.User;
import com.bjpowernode.pojo.Value;
import com.bjpowernode.service.TypeService;
import com.bjpowernode.service.ValueService;
import com.bjpowernode.utils.UUIDUtil;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@ContextConfiguration("classpath:applicationContext.xml")
@RunWith(SpringJUnit4ClassRunner.class)
public class f1 {
    @Resource
    ValueService valueService;
    @Test
    public void fun1(){
        valueService.add( new Value(UUIDUtil.getUUID(),"xx","女","11","111"));
    }
    @Test
    public void fun2(){
        List<Value> all = valueService.getALL();
        for (Value value : all) {
            System.out.println(value);
        }
    }
    @Test
    public void fun3(){
        Value value = valueService.getOne("becc4a47dcf34efab6853dbd3a393c83");
        System.out.println(value);

    }

    @Test
    public void fun4(){

         valueService.update(new Value("becc4a47dcf34efab6853dbd3a393c83","www222","22222","222222","111"));


    }
    @Test
    public void fun5(){
        valueService.delete("becc4a47dcf34efab6853dbd3a393c83");
    }

    @Test
    public void fun6(){
        List<Value> typeCode = valueService.getTypeCode("111");
        System.out.println(typeCode);
    }



}
