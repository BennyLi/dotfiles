# .dotfiles

Here you find my personal dotfiles.
These include configuration files for my desktop systems and my server systems.

Feel free to use any of these files for your usecase.

## How I use this 🎓

To keep things clear, every application has it's own folder.
In these folders all configuration files relevant for the application are stored.

### Sensible data 🔐

Sensible data, like credentials, URIs, private names and so on, will _(hopefully 🙏)_ never be commited to this repository.
If any sensible data in a configuration file is needed, it will be replaced by an [Ansible Jinja2 Template](https://docs.ansible.com/ansible/latest/user_guide/playbooks_templating.html).
Why? Cause I'm setting up my devices with [Ansible](https://docs.ansible.com/ansible/latest/index.html).
