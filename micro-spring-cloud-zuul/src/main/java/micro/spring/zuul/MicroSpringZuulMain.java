package micro.spring.zuul;

import org.springframework.boot.SpringApplication;
import org.springframework.cloud.client.SpringCloudApplication;
import org.springframework.cloud.netflix.zuul.EnableZuulProxy;

/**
 * 网关路由
 *
 * @Author: shengbin
 * @since: 2019/4/29 下午2:09
 */
@EnableZuulProxy
@SpringCloudApplication
public class MicroSpringZuulMain {
    public static void main(String[] args) {
        SpringApplication.run(MicroSpringZuulMain.class, args);
    }

}
