#!/bin/bash
# PAM nos da la variable $PAM_USER
guestuser='convidat'

if [ "$PAM_USER" = "$guestuser" ]; then
    # Borramos el home existente
    rm -rf /home/$guestuser
    # Lo recreamos desde el esqueleto del sistema
    cp -r /etc/skel /home/$guestuser
    # Creamos la configuración para saltar el asistente de GNOME
    mkdir -p /home/$guestuser/.config
    cd /home/$guestuser/.config
    echo -n yes >gnome-initial-setup-done
    mkdir -p gnome-initial-setup
    touch gnome-initial-setup/upgrade-26.04-done

    echo "consent_state = false" > linux-consent.toml
    echo "consent_state = false" > ubuntu_desktop_provision-consent.toml
    echo "consent_state = false" > ubuntu_release_upgrader-consent.toml

    # Ajustamos permisos
    chown -R $guestuser:$guestuser /home/$guestuser
fi
