# Image RunPod pour le rendu 3D des vidéos Explainer (Maison 9, 22/10/2026) : Blender + ffmpeg + EGL déjà installés,
# pour que rendu_cloud.py n'ait plus rien à télécharger au démarrage d'un pod. Rien de privé ici : Ubuntu, ffmpeg, Blender.
FROM runpod/base:1.3.3-ubuntu2204
ARG BLENDER=5.2.2
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      ffmpeg rsync xz-utils curl ca-certificates libegl1 libgl1 libglu1-mesa libvulkan1 libxi6 libxkbcommon0 \
      libxxf86vm1 libxfixes3 libxrender1 libsm6 libice6 \
    && rm -rf /var/lib/apt/lists/*
RUN curl -fsSL --retry 3 "https://download.blender.org/release/Blender${BLENDER%.*}/blender-${BLENDER}-linux-x64.tar.xz" \
      | tar -xJ -C /opt \
    && mv "/opt/blender-${BLENDER}-linux-x64" "/opt/blender-${BLENDER}"
# sans « graphics », le pilote NVIDIA n'expose pas EGL → Eevee ne voit pas le GPU
ENV NVIDIA_DRIVER_CAPABILITIES=all
