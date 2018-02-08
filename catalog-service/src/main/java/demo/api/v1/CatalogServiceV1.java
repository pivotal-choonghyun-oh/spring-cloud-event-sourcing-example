package demo.api.v1;


import com.netflix.hystrix.contrib.javanica.annotation.HystrixCommand;
import demo.catalog.Catalog;
import demo.catalog.CatalogInfo;
import demo.catalog.CatalogInfoRepository;
import demo.product.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cloud.client.loadbalancer.LoadBalanced;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.stream.Collectors;
import java.util.*;

@Service
public class CatalogServiceV1 {
    private CatalogInfoRepository catalogInfoRepository;
    private RestTemplate restTemplate;

    private Catalog lastCatalog;
    private Product lastProduct;
    private HashMap<String, Product> hashmap;

    @Autowired
    public CatalogServiceV1(CatalogInfoRepository catalogInfoRepository,
                            @LoadBalanced RestTemplate restTemplate) {
        this.catalogInfoRepository = catalogInfoRepository;
        this.restTemplate = restTemplate;
	this.lastCatalog=null;
	this.lastProduct=null;

        this.hashmap = new HashMap<>();
    }

    private Catalog fallbackGetCatalog() {
	lastCatalog.setName("-HYSTRIX-:" + lastCatalog.getName());
	return this.lastCatalog;
       // return new Catalog();
    }


    @HystrixCommand(fallbackMethod = "fallbackGetCatalog")
    public Catalog getCatalog() {
        Catalog catalog;

        CatalogInfo activeCatalog = catalogInfoRepository.findCatalogByActive(true);

        catalog = restTemplate.getForObject(
                String.format("http://inventory-service/api/catalogs/search/findCatalogByCatalogNumber?catalogNumber=%s",
                activeCatalog.getCatalogId()), Catalog.class);

        ProductsResource products = restTemplate.getForObject(String.format("http://inventory-service/api/catalogs/%s/products",
                catalog.getId()), ProductsResource.class);

        catalog.setProducts(products.getContent().stream().collect(Collectors.toSet()));

	lastCatalog = catalog;

        return catalog;
    }

    private Product fallbackGetProduct(String productId) {
	Product product = hashmap.get(productId);

	product.setName("-HYSTRIX-:" + product.getName());

	return product;
    }

    @HystrixCommand(fallbackMethod = "fallbackGetProduct")
    public Product getProduct(String productId) {
        Product product =  restTemplate.getForObject(String.format("http://inventory-service/v1/products/%s",
                productId), Product.class);

	hashmap.put(productId, product);	

        return product;
    }
}
