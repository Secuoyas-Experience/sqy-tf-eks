# Changelog

All notable changes to this project will be documented in this file. See [standard-version](https://github.com/conventional-changelog/standard-version) for commit guidelines.

### 1.22.15 (2025-06-26)

### 1.22.14 (2025-05-05)

### 1.22.13 (2025-04-21)

### 1.22.12 (2025-04-14)

### 1.22.11 (2025-03-11)

### 1.22.10 (2025-03-04)

### 1.22.9 (2025-03-04)

### 1.22.8 (2025-03-04)

### 1.22.7 (2025-03-04)

### 1.22.6 (2025-03-04)

### 1.22.5 (2025-03-04)

### 1.22.4 (2025-03-03)

### 1.22.3 (2025-03-03)

### 1.22.2 (2025-02-27)

### 1.22.1 (2025-02-27)

## 1.22.0 (2025-02-27)


### Features

* **all:** update eks to 1.31 ([c833617](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/c8336175f516c5fe7e1ba413db35611df182edce))

## 1.21.0 (2025-02-27)


### Features

* **eks-driver:** add driver version in the tfvars ([ff1a300](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/ff1a3004b9fd40e68dc92c46ce594a448c6fcc84))

### 1.20.1 (2025-02-27)

## 1.20.0 (2025-02-12)


### Features

* **all:** upgrade eks to 1.30 ([0650b82](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/0650b82f55e9a99682840a0fb9722c400dfa641a))

### 1.19.2 (2025-02-12)

### 1.19.1 (2025-02-12)

## 1.19.0 (2025-02-12)


### Features

* **all:** add new variables ([afc002a](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/afc002a3ca9976c1f685dbecefc6f84f297005e1))

### 1.18.1 (2025-02-11)

## 1.18.0 (2025-01-28)


### Features

* **karpenter:** update karpenter module and stop managing karpenter with terraform ([a12e6a6](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/a12e6a6138199b9869408dcba9aa45e51ecdb020))

### 1.17.1 (2025-01-23)

## 1.17.0 (2025-01-23)


### Features

* **karpenter:** update karpenter version ([def527a](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/def527a9bd0eaa1168af22b9f1d20a3cff5ff018))

## 1.16.0 (2025-01-23)


### Features

* **karpenter:** update karpenter version ([e2e5128](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/e2e51288483032eb2e107f13db507c5b4092e593))

## 1.15.0 (2025-01-21)


### Features

* **eks:** update karpenter version ([4657edf](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/4657edf001909eb9b8095d40da4a7f22f2e6eebc))

## 1.14.0 (2025-01-21)


### Features

* **eks:** update eks 1.29 -> 1.30 ([6cf3a57](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/6cf3a571c7805256d5598b9213bb82b80d7d057e))

### 1.13.2 (2024-11-12)

### 1.13.1 (2024-11-12)

## 1.13.0 (2024-09-16)


### Features

* updating aws provider version to 5.67.0 ([44aa081](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/44aa081cf495d8988ac999837137d580ac1eb589))

### 1.12.4 (2024-09-04)

### 1.12.3 (2024-04-16)


### Bug Fixes

* **addons:** set default value for velero s3 arn ([9d44de2](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/9d44de25c06f23cb7fb1bbace5331fa69d177384))

### 1.12.2 (2024-04-16)


### Bug Fixes

* some terraform fmt in velero files ([1ecbb90](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/1ecbb90ca51569ec6edec9074c46a29e5c7ed2ae))

### 1.12.1 (2024-03-15)


### Bug Fixes

* adding additional rules for node-to-node traffic ([34b65b4](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/34b65b4dd43d519dcd5378ad4ca27547f6afa512))

## 1.12.0 (2024-03-12)


### Features

* optionally adding cluster sg rules to allow private endpoint access ([f9cb388](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/f9cb388a9ac84cfe90e0b1f968a3e895f3b65cfd))

## 1.11.0 (2024-03-09)


### Features

* increase addons exposure ([ec19245](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/ec19245593a63fde20cea177773eaa22518bdccc))

## 1.10.0 (2024-03-07)


### Features

* adding variables to control cluster visibility public/private ([0bdbee1](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/0bdbee12d692648be9088cb495a359e8d5948747))

## 1.9.0 (2024-03-04)


### Features

* avoid adding default karpenter nodepool ([ecb955d](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/ecb955d00f6ab7595f25c9b0b4a9ffcb0e22d1da))

### 1.8.1 (2024-02-21)


### Bug Fixes

* wrong default policy for cluster admins ([f1280c7](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/f1280c7ecc1dc49d5f6181c28f6bc25e49d2c73f))

## 1.8.0 (2024-02-20)


### Features

* get rid of unused modules ([51d999b](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/51d999bf246142774c8d90d4a9d06985a20df3cb))

### 1.7.3 (2024-02-20)

### 1.7.2 (2024-02-20)


### Bug Fixes

* keep same aws versions for all addons ([bb1441a](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/bb1441a434c4552fbc9b7284745979dfb9271168))

### 1.7.1 (2024-02-07)


### Bug Fixes

* adding efs driver by default ([0fba509](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/0fba509f10cffb2050dea93aace9ffc889ee9445))

## 1.7.0 (2024-02-07)


### Features

* adding posibility for adding extra storage classes ([6202c89](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/6202c89d8b2785a5fd1993e7a722b7832c307c5d))

## 1.6.0 (2024-02-06)


### Features

* adding outputs to interact with other dependant modules ([3ff87a0](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/3ff87a012760c9b00be1fb83418af61ebd7ee7d9))

### 1.5.1 (2024-02-06)


### Bug Fixes

* public repositories can't use private runners ([dcb0420](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/dcb04203aca8d656e1ab57a3dea943f5964b15c3))

## 1.5.0 (2024-01-30)


### Features

* forking velero from aws addons terraform project as new module ([f109ffe](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/f109ffe0b0fd45cb596b0735116abc635c2b9944))

### 1.4.9 (2024-01-30)


### Bug Fixes

* velero s3_backup_location should be a slice ([cce8df2](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/cce8df2912e726a8d6400bf62fdd085fbd92da87))

### 1.4.8 (2024-01-29)


### Bug Fixes

* example is not correct ([bcc34fe](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/bcc34fe486ae2bf1fd4d526cb9c353612b394ed4))

### 1.4.7 (2024-01-29)


### Bug Fixes

* get rid of backend and parametrize aws region ([2750d2d](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/2750d2dbf8ed8beb80008f4efbc2a8e01cb51621))

### 1.4.6 (2024-01-29)


### Bug Fixes

* git pushing and checkout in different jobs fails ([88b596d](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/88b596d89d1dc2d0e1d6d04cea4c44d5fd1b249c))

### 1.4.5 (2024-01-29)


### Bug Fixes

* getting latest tag corrupts the git checkout ([b532ac2](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/b532ac2c0a47eb028c53b7d6dc5c8a89e6f9f20e))

### 1.4.4 (2024-01-29)


### Bug Fixes

* terraform docs pipeline in main ([89e76d0](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/89e76d005156ab46ce02c69bc5620bf29d7a24a2))

### 1.4.3 (2024-01-29)

### 1.4.2 (2023-12-27)


### Bug Fixes

* broken docs link in README ([b8ba675](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/b8ba6757bca6b9c9bf910dc9a8d62a771f3bc007))

### 1.4.1 (2023-12-27)


### Bug Fixes

* not using config-file for terraform-docs ([846897f](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/846897fea0fdb9ac111d656315aaa746e9570efb))

## 1.4.0 (2023-12-27)


### Features

* getting rid of node related files ([85281e5](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/85281e574f80e756effb0f2b54d4b2505e400b58))

### 1.3.3 (2023-12-27)


### Bug Fixes

* missing .terraform-docs.yml reference in workflow ([5f3eca8](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/5f3eca81e9a5b80ac6d2ef47e1cffce92b101fca))

### 1.3.2 (2023-12-27)

### 1.3.1 (2023-12-27)

## 1.3.0 (2023-12-27)


### Features

* adding workflow dispatch for docs pipelines ([ad423c2](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/ad423c2ec38edc3980c6a3196eeb75d586c612d4))

### 1.2.1 (2023-12-27)


### Bug Fixes

* ci when regenerating terraform docs ([ee30f20](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/ee30f20b1def3d033750492324cb5186d2f7a36b))

## 1.2.0 (2023-12-27)


### Features

* adding auto generated docs ([6cb7d59](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/6cb7d5998ef3618ebfd8a61a438e0b42bfe47d71))

### 1.1.1 (2023-12-27)


### Bug Fixes

* using temporal email for tag push ([200e92c](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/200e92cec5968cd5087b78b04a63697780931156))

## 1.1.0 (2023-12-27)


### Features

* add new TF phases and autoapply ([a3206bc](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/a3206bc856da049d9e68658a5fc1cc8149e9c3c6))
* adding argocd to default k8s installation ([78f1e69](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/78f1e691f00b3005791cf406725e29864c63f823))
* adding cert manager as github actions controller needs it ([91ee1f6](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/91ee1f6ee17bea08a1d4fdf16db8cbed94d95e0d))
* adding doppler operator to cluster ([310fbb4](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/310fbb4edc78d8301e35eca1e8870ffcdbef9f7e))
* adding externalDNS for managing DNS entries via manifests ([34db980](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/34db980de5309d3334a8562c6f63da96e20b6939))
* adding helm loki installation ([032b8b3](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/032b8b3bf0faec2105cd550a71224f651b3ea6e1))
* adding terraform cloud ([dc7c4b3](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/dc7c4b3af1b6b70bef89e368a8e09c88acee0b12))
* adding velero backups ([40c54fe](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/40c54fe9faddc776228a1772e2739965ae75cc13))
* auto run with branch push ([53083f0](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/53083f0555d630c65843393b840cbf918bb08c6c))
* changing runner to toolbox-secuoyas ([1f8c4b5](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/1f8c4b5ead5bd1314a3f285e7dc52e6e8376a710))
* check passing secret links from secret mounts ([175d9b3](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/175d9b35caa6eebe404dcd5d0eb520dc69aa9e77))
* configuring cert-manager to allow dns acme challenge ([f3472e7](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/f3472e78bae38b887b0028df5783578a2d4ce63e))
* configuring grafana from doppler ([e545e39](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/e545e39ac93b94a48ab462219f03e77aef7ca787))
* create a hosted zone only if it didn't exists before ([503edee](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/503edeea4ddb9f660eaf5d46f1cc80e61075e382))
* custom kube-prom config didn't work ([a18584c](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/a18584c07998987c7498dc46b7a152fe92a689b5))
* exposing grafana to the outside world ([9cbb03e](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/9cbb03e33046f4d1a3b32a994ec46ddcc68eb608))
* migrating state to terraform cloud ([032acf0](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/032acf0398c892a74e8d633d050f3b813672f229))
* migrating to tc ([34d945e](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/34d945e07b96b8b2e4312c572861578624415f26))
* new k8s infra completely using terraform ([09501d4](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/09501d44466d93873e062aaeaf08d1b1abbbd9c2))
* new tf action ([ed502cd](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/ed502cdfb03ad754e1af492ba9a35d1e0124951f))
* preparing documentation with mkdocs ([b8eb3fa](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/b8eb3fa462c3c9c07881ae69a8ff0eaf920f7344))
* renaming terraform files ([af27514](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/af275143d93391027adc8612e79e0a2bf77141ba))
* slack notify and timeout ([b164125](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/b164125033616dd1d84d8ce7d45631be9c0fe813))
* start sync with backstage ([3bfaf0d](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/3bfaf0dba821f9edd0a158bc27ce97b10c5ca0c2))
* terraform eks+prometheus+cert-manager+karpenter+aws-lb+ebs+metrics working ([b86fa3f](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/b86fa3ff0e8f4240baacc7ebde92ac3c75d47e86))
* uploading techdocs to S3 ([0b46af4](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/0b46af4433d22be9d831497250720be5a315375a))
* using gha-backstage-docs action ([f384311](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/f384311e33a7fc51324320af546a1a1305e02eba))
* velero backup working with default backup-location ([881dc57](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/881dc575490e9b3d5388dcd2029bf6a65052aa30))
* working base k8s 1.24 with default karpenter tags ([298fef8](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/298fef8a3ccb19d7ef14d40e513cf9f3cd0d6573))


### Bug Fixes

* add alternative way of auth against eks cluster ([c682c26](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/c682c260281274921e4e513cafacfab8dfaa21c1))
* add auth beta version ([099018d](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/099018d60be902dca9c4ef56a4f36554e26b3898))
* add iam role for enable users to login to eks cluster ([12ed945](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/12ed9451abca936d8389cb99a539d184f8796878))
* add namespace where loki will be installed ([dee0575](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/dee057513a6ecb6f8123306f2bd0e4855963abff))
* add policy to read images from ECR ([4b59ceb](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/4b59cebd1a6dfbff9119199087e111d0da34055c))
* adding arn role when getting token ([c85d0ce](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/c85d0ce458475d9b3b21f8b662fe5846200eae18))
* adding chart name and version ([5b7ccfd](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/5b7ccfdc59aa882d4ec795b152b3dfee800fc1de))
* adding module to mkdocs and link to eks logo ([8f61044](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/8f61044257856cdc0dce1adbb239d29e71ee8995))
* adding more resources to github runners ([fe1324d](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/fe1324db784d497a057fc259463c4ac394501e53))
* adding serviceaccount to helm chart ([6d1160f](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/6d1160f084a2d4c7ab345326b7d674ce1b8301d8))
* adding terraform destroy and make everything manual for now ([1594687](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/159468715632d25e8f04f8dc85448ea86e6d3f5c))
* adding TF_VAR_ ([20afed9](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/20afed9accd720caa9b720fc719b07b5cc385710))
* ading timeouts ([298b8b1](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/298b8b146316a1823ec72d136b54e0f5257bf4c8))
* all md files should start with one # as they represent a new section ([61a16dc](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/61a16dcdc2ab108825ebbe1e06b91eea50a50eb4))
* allow admin users to get kubeconfig creds ([1f175a9](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/1f175a9617ca5e8ee6a219bd3f135211e63df647))
* allow kube-admin to pull ECR images ([c573fd5](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/c573fd5f1a8a7684b9bcbd7db80fe4aa04a6c624))
* annotations should me a map ([4482178](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/4482178ab7b58796efc76dc59548ec23b754b404))
* another test ([4059d43](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/4059d435dc170fd90733a92b2c486e91e9cd5262))
* aws cache ([dd7cc4a](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/dd7cc4a2cdf60260be39cbb3e70fdc53273cef2c))
* aws cache again ([56f1b74](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/56f1b74d35ed95a04f1e4efd57f52fc1cad9cdd4))
* aws id used in both doppler secrets ([164956d](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/164956d3c1f88c153032a26572063175127c9a07))
* backup not showing possible mismatching between server/client versions ([f4b9602](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/f4b9602a48967fdfe41d3395d8e6368ad69b0fb0))
* backup to velero 1.10 because eks blueprints 4.32.1 doesn't support helm values for 1.11 ([3ab8f30](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/3ab8f3029540035be4e2648cdb7fa1df56ad238c))
* bad indentation ([95aa23a](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/95aa23aa8a4cc77800844e393eacf985d3dec792))
* building docs without external github action ([ccb9dfa](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/ccb9dfaf3dad9daa5e7e278f73caa769ae934217))
* change links from resources to oidc resource to its data ([29f0462](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/29f0462b7b886e78300d19bd90256ca7be0bfc2d))
* change name and workflow dispatch ([d0bd2c1](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/d0bd2c1ef6ab3a71f38b52b60283449d9bb57e56))
* change role arn ([baae542](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/baae54290ca2264715519c6b31185447cdca686c))
* changing authentication version ([abce9af](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/abce9af769c95588af7d03ea81797d88314a2bdb))
* check just k8s provider ([ad69eee](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/ad69eee6efb99aec9e3ed3451ca736580724285e))
* check token ([9479330](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/947933023d9e9b6a48b5a7c191a11f5063d9b7dd))
* checking aws-auth when creating cluster with tc ([167143f](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/167143f351aa6f2506e121bcc218e2b1e2c99f1a))
* checking kubernetes providers works ([7746c9d](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/7746c9dee66575c4e43bf61a7df159f264ac1fb6))
* checking kubernetes providers works ([3a3a2e8](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/3a3a2e8506926320513937c86ffeeb392804046d))
* checking kubernetes providers works ([9ee54ad](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/9ee54ad9af44ac98e7b20563f8528de042816609))
* checking kubernetes providers works ([c3aabbf](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/c3aabbfb7cba5acc29dc3a8c054b17d3d1db7337))
* clean warnings ([4bbbd28](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/4bbbd28dfebccbb21daf8a4b4a041c76e5e92d36))
* cluster name not properly set for aws load balancer operator ([b586641](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/b5866412404050369513100a5b23dd2fdc6052ba))
* cluster_id is only available in local env ([b0a53ef](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/b0a53ef5c15c9d0e2a96d07f3fb8cd13b69fa1cb))
* comment profile ([ce137f5](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/ce137f557cd4856b287ee8fc39c8cffddbbbc655))
* constant drift because missing patch version in cert manager chart ([c8078bd](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/c8078bdec193324ac9c8fa5817326966c591b3f2))
* copied naming should change to backstage ([a4c4b97](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/a4c4b978a3e2015f337e11af62da89dc6d4182ae))
* CopyObject doesn't exists ([b8fb94c](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/b8fb94c376af8926128757623f81ef795317f33f))
* destroy and then test with downgrade ([400383a](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/400383a7669c98761a86302dc0fcadce11fa7b3c))
* docs and site not where expected ([de432a5](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/de432a5470cfea1542dfa4ec5ab9adf16bf6a846))
* docs and site not where expected ([887b995](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/887b9958f4f70c206d6e044be285c5aa98469517))
* docs and site not where expected ([1c6b8a4](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/1c6b8a47fa97ebed27b47aa6decd1bf75d36d1fd))
* docs and site not where expected ([aa8942c](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/aa8942ce4769ebd25826b3460b67758b300e5f28))
* docs make them generic to clusters ([636a063](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/636a063c14018609962f0f6d33582eb07ca0ebc9))
* documentation grafana/google oauth ([965283b](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/965283b22274cc117998792dcf709b0454f17e65))
* don't create access key by default ([a129d49](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/a129d49a3d31bc47919eaa18deca9dcff37a47c8))
* don't know how to sync already created oidc provider ([428f136](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/428f1369498bc6cc81abcdc089b1a0d1402945ae))
* don't omit already deployed infra ([6899c72](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/6899c72ef4828842cc7c7ef157cbc1bce64f1ed5))
* don't remove already created infra ([bca489c](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/bca489cf77a30edf3198f1c9a01c18b09f8255b1))
* doppler annotation is not parsed properly ([716ac61](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/716ac618f01fc627c65c72cd5ae883b09b0bc4b3))
* downgrade aws provider ([240442c](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/240442c551a4f331f68b188e97cc14b4657de7f3))
* downgrade aws provider ([e2e6828](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/e2e68287fe59faf66618b4100bfef38ed6a59c40))
* downgrading aws provider ([cb763e0](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/cb763e0a09c3673770194469487f33394b0373eb))
* eks blueprints deploy grafana service in 80 ([bce36e3](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/bce36e315141d1a7075dadaa7259c5cacd5cd62a))
* error because docs dir is not found ([2e22245](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/2e22245dfaee432651a42390dff30dc3b68ff6dc))
* executing helm and providers isolated ([bf92a7f](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/bf92a7fc416b961229db4673aa494462e764f05d))
* externalDNS complaining not knowing hosted zone id to handle ([c57fa66](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/c57fa661a95521356b15a9156d5eb95c0e41496c))
* fixing slack notification when successfully destroying cluster ([0cb487b](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/0cb487b2ffd9074330d953230098db287e83b970))
* fmt failed because new comments ([b072ebb](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/b072ebb92b3b165959e72f7c438c831b89e19591))
* get rid of profile in configuration as it's going to be executed in TC ([2a0b967](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/2a0b9677c76c263499d07173ac0b010ee5c7d715))
* get rid of warnings because outdated actions ([dcea182](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/dcea18254cfe7dc946af89d73658392c83df7648))
* get separared helm and k8s providers ([dbf4f0c](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/dbf4f0cded30865ab764833e83ae9f718346fe75))
* getting oidc information directly from cluster ([8296e9c](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/8296e9ce29d9015efda058451fc18ae192add733))
* getting rid of chart attribute favoring name/repository ([0a491e0](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/0a491e090a3ea4c437799f7e4f5b64e6fdf4696c))
* grafana listens to port 3000 ([7069b35](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/7069b355cd4c2e39c0d8c56ddbd68871ad3e8bfd))
* helm chart name ([c2d0fc0](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/c2d0fc012f046e35ea976bb9a49e4fdce875bc07))
* helm release already creates namespace ([84d948a](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/84d948a8428f28f8e61a4fce8bca23ae0e71158a))
* increment timeout time ([288e20d](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/288e20df92592ac7d232cd35f8a72654f04d6cd8))
* karpenter and load balancer behavior ([3ebc5ae](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/3ebc5aee3d0770467a1a2f546ea6c15b67db27a6))
* karpenter not picking up new settings ([67f2987](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/67f298771299b154aca7fa25f42e7fc3260a23a4))
* keep chasing docs dir not created ([887fe2d](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/887fe2d22b767c3265b3f9f1b44ef8f844ced12c))
* keep checking cred variables ([4eb1ece](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/4eb1ecede6fd8ef59c086f76af0fbe86bda78a16))
* keep doppler secret naming conventions ([8464a54](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/8464a54fbfe384b6db098be59cf6f7d81a0c7585))
* leaving k8s configuration for later on ([ddd07dd](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/ddd07dd42bdf232b16ad92933b3688f9522b85fc))
* locally worked so it seems something related to IAM ([cd9395d](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/cd9395da5b62336a459511493e0755fcb0d7d688))
* make sure bucket has been created before looking for it ([5c58a72](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/5c58a72b54b4b40c76fe78adf769e286e48c0015))
* mfa enforcement was enabled by default ([f6a12c3](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/f6a12c3e940f7616be2b9f46474e1aff8425ecb7))
* misplaced argument group -> user ([569af61](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/569af61677b6107ae1ad0e415fcf41269af33214))
* missing bucket because one variable shadowed the one passed in helm config ([ac0e8f9](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/ac0e8f9099920495d2ff7b814869eec14f4d952c))
* missing checkout :tired_face: WTF! ([4fc493b](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/4fc493bb5de3355d8da133aec30a3fe5085030dd))
* missing dependency between jobs ([0c65bea](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/0c65beabdf043390630b8a588ada0dcb4efd148f))
* missing gha-backstage-docs inputs ([5c5b284](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/5c5b2845a3fe077955e03b8aedf8b983ed42db2a))
* missing oidc token because missing permissions block ([32cca90](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/32cca90b285902802470250777e50c28066533b8))
* missing prefix in assume role policy document ([e5ea9fd](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/e5ea9fde8cd10465643ebe32712e35d49bde9da8))
* missing removal of data in dependant files ([e96e4e1](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/e96e4e1cdedfbff7c8af30b6fcfc591769f45cdc))
* missingn docs_dir in mkdocs config ([3215c6b](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/3215c6bd1a3d9c9acff39c2d8da703aa27a3e144))
* modules should not use depends_on as update will fail ([efebc80](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/efebc805061313e672a324c192fc027b0bc96a5b))
* name of the chart should be distinct form the module name ([5f9f071](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/5f9f071639550fae35bc63c812bfad017b961240))
* not enough permissions to create ebs volumes ([1062b67](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/1062b677aaf3ccdfa7c3363531630159c3a14c70))
* only k8s ([0b24bf1](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/0b24bf18cff372b4c20d98b4f1f26ef0eec8922e))
* ref removed karpenter provisioner template ([d98dab7](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/d98dab7c933bb0cea2910cb6c4bc346317eaca9b))
* reinstalling velero part one ([31a9017](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/31a90179b049d61a31c3389bac59c33a66e04793))
* reinstalling velero part two ([f6882b1](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/f6882b12da282f3760d29285322b8599a83b0c20))
* remove empty action ([ab01ec3](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/ab01ec321c49f7172f078b6811121fbb6bc35b43))
* removing explicit profile ([7c2d5ff](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/7c2d5ffcf0f8d0e13a05c1cfaf4986b36cb55abb))
* removing warnings in Terraform cloud ([43b1e7e](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/43b1e7e7e211aa1f55aa3b7e7bcbfe5a8fa74810))
* renaming folder to name of the project ([35e3163](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/35e316368a2d2a2afb835a1ed1a7e3eaf58a9504))
* renaming lab -> toolbox was not documented ([1f9fdfc](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/1f9fdfc95d3d5294003d2333c4a751003a882c02))
* s3 bucket permissions ([5839d2c](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/5839d2c07e406064bf5fd1152720f5f87f491a4b))
* s3 reading permissions ([cbd5b65](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/cbd5b65e18666212ff7656aa467c84a3b3637b59))
* s3 still doesn't allow specific user to use it ([2cf40e3](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/2cf40e3832cb32bcb71fe75ec22f01c9862d5d26))
* same alb group name for all apps in toolbox ([6d3baa9](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/6d3baa93c47856e6d451de2b010084a5dc01a7ef))
* set properly tc workspace name ([c308ee9](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/c308ee917caf46d0ad615d1799d228050d628d72))
* set specific versions for node and python ([70356b4](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/70356b4a318507ae8c7d223f888d11921f5cc58d))
* setting provider explicitly ([14d8fd2](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/14d8fd27e2cf6d9755c56480668673a8d62309c6))
* still chasing docs dir isn't created ([e9838a2](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/e9838a220113c1e50c5f345481f9368e071e6519))
* still chasing docs dir isn't created ([a69e280](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/a69e280fbbddf763bf14f984060eb2fd4c236efd))
* still chasing docs dir isn't created ([3673562](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/367356246774b935f954a9362cf2f5eb18437481))
* still wrong creds to auth to eks ([995b608](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/995b6084e2869d45843615716047ad323a74c903))
* still wrong creds to auth to eks ([91f5af2](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/91f5af224da437da730156e238aef2e3f3bb6779))
* still wrong creds to auth to eks ([5feadb4](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/5feadb4de6fc132cd11a9c64ea45298f9834e3cf))
* still wrong creds to auth to eks ([74260b5](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/74260b5402faed9e22dfc9c3746b3a2d1ce9c2bf))
* still wrong creds to auth to eks ([810a2d5](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/810a2d5fc83ed5ffda08843a1760509b74036dd2))
* still wrong creds to auth to eks ([9f63149](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/9f63149580ce451676d1bbde06f59dc42d3648f2))
* terraform helm set values can only be strings ([108aaa0](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/108aaa0a6874c6e4989f3f0cc27d22098dbec1d5))
* testing another role ([ca51426](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/ca51426f4bb18e125a4fb9e1890b507294388a85))
* testing new workaround ([3421b9c](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/3421b9cf8bb5393a313e37275d47052305ce257c))
* testing new workaround ([747262b](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/747262beb5e6f22373a05939a0630393f7bda53c))
* testing new workaround ([d3d796f](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/d3d796fd96914f9ceae3c79aebe70af1e95a3741))
* trying to delete cached creds ([fea01fa](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/fea01fa7b55efa572cae74f82a46378c32f42e0a))
* trying to make the helm chart work ([19afc22](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/19afc228d1b2c16aa27b6581775b0198f3e0758b))
* trying to make the helm chart work ([bd347d8](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/bd347d8d462237f417c471f0e17064b492788493))
* trying to make the helm chart work ([014e2e7](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/014e2e7069116e3dba93faea5a3f79bbf77c40bf))
* trying to make the helm chart work ([22d4b0a](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/22d4b0aebe62796480324a6a47052d4c240a90dd))
* trying to make the helm chart work ([9622f7f](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/9622f7f034d4e58f7177f532ccb3ee1b6cb31d01))
* trying to update to velero 11 2nd try ([6c5d486](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/6c5d486280fbb6b901700ddf7153d375883bbf3a))
* typo in helm chart ([afdee11](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/afdee11879ef46c255f97a595e7d1042d1742dbb))
* unresolved arns of oidc providers ([3ce1283](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/3ce128392aef6c770ff538bcc85d44b0749cb3b5))
* updating several components and refactoring some others ([9f88470](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/9f88470f27e5af0a7a66b56790650eb409616a8e))
* updating terraform aws blueprints to specific version to avoid helm addons missing ([ff2d4ee](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/ff2d4ee23ee24b47bbf071a49c4f20cc97d207e6))
* upload failing because ListObjectV2 complain ([2d5e92c](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/2d5e92c5dde7b46e99325a4bfec9a3defc440f45))
* use arn in aws provider ([cf77a52](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/cf77a52d201a3d02c452ba3749381afee77654ae))
* use proper eks auth mechanism ([17b22a6](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/17b22a664d25cc2f1dd2b146181c73d52c3a8468))
* using artifacts to share files between jobs ([33ed7c8](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/33ed7c8cc78fea513e6f31ebdbd9440f169beb00))
* using exec as auth ([3e75efb](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/3e75efb5d12ed4b2e2ce5641f881bbd3e44200ea))
* using explicit credentials ([fa364b6](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/fa364b6f050b6b641b51adbcc3bd006799a28dec))
* using hardcoded cluster name ([45f06b6](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/45f06b63746a5f06798ce2b5f6dfde0dbb75fcad))
* using specific helm provider with alias ([48ba168](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/48ba1689db6dfb09551810964a0ec9dcddca6474))
* variable is missing ([fc9188e](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/fc9188e255ef9d890c3c7e78f22eef6a38fcc4e0))
* variable is missing ([6f6fc8e](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/6f6fc8e8f33d85b597906f2e9016c36c3429a06c))
* widening permissions ([905521e](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/905521e39b37de3f1e3f7d511376d98510b909b0))
* working cluster with vpc,ebs,metrics,karpenter,prom,velero working ([92a4fd9](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/92a4fd94fd45232cbbcc131ef7520ee26c41d673))
* wrong alb name ([56d466b](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/56d466ba2a7645a6d8702b888d8bcb6fe458ec5c))
* wrong alb name ([71b1e92](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/71b1e923c696a60ec496dded2a6a703b72e55c26))
* wrong backstage group ([2c438ca](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/2c438cabe9d1dd4a15f426c8ec9c8d59720a7132))
* wrong dependency resource ([9250181](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/9250181db58bd1560be4426dd6c65f14951aa81d))
* wrong doppler project and wrong s3 path ([d71b32b](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/d71b32b1df68c085141d7ede2d185a3e0a03211c))
* wrong github action artifact path ([ef35d5c](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/ef35d5c11452daaa736e31ffc5554105ce462f09))
* wrong naming in grafana dns resource ([60b1b99](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/60b1b993db8906bd5b426a58c5bb6d6cdbfc5dc7))
* wrong syntax check ([40bc93e](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/40bc93ee92d176c00c5dd3895696306f9a21eb72))
* wrong terraform data reference ([5791f9d](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/5791f9deafd63e58d9a7cb44ffed9113cc54c1f0))
* wrong velero helm version ([d3ac204](https://github.com/Secuoyas-Experience/sqy-tf-eks/commit/d3ac204e2820001bba5af7788f5a5be3c51bc8fc))
