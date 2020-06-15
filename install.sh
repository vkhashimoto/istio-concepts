ISTIO_VERSION=1.6.2
ISTIO_FOLDER=istio-$ISTIO_VERSION
curl -L https://istio.io/downloadIstio | ISTIO_VERSION=$ISTIO_VERSION sh -

export PATH=$PWD/$ISTIO_FOLDER/bin:$PATH

# https://istio.io/latest/docs/setup/additional-setup/config-profiles/
# istioctl install --set values.gateways.istio-egressgateway.enabled=true --set meshConfig.outboundTrafficPolicy.mode=REGISTRY_ONLY -y
istioctl install --set profile=default --set meshConfig.accessLogFile="/dev/stdout"  --set values.gateways.istio-egressgateway.enabled=true --set meshConfig.outboundTrafficPolicy.mode=REGISTRY_ONLY -y

# istioctl manifest generate --set components.egressGateways.enabled=true > generated-manifest.yaml

kubectl apply -f repo/metrics-server.yaml
kubectl apply -f repo/private-gateway-def.yaml
kubectl apply -f repo/base-def.yaml
kubectl apply -f repo/general/.


