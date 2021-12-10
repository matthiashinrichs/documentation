HAProxy als Loadbalancer

``` mermaid
graph TD;
    Internet-->HAProxy;
	HAProxy-->k1[Kubernetes Worker 1];
	HAProxy-.->k2[Kubernetes Worker 2];
	HAProxy-.->kn[Kubernetes Worker n];
```