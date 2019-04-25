package micro.spring.cloud.ribbon.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

/**
 * @Author: shengbin
 * @since: 2019/4/21 下午5:51
 */
@RestController
@Slf4j
public class RibbonConsumerController {
    @Autowired
    private RestTemplate restTemplate;

    @GetMapping(value = "/ribbon-consumer")
    public String helloConsumer() {
        return restTemplate.getForEntity("http://SERVICE-API/hello", String.class).getBody();
    }
}