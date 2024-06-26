# International Workshop on Security 2024 - Materials and Script


## Description
This page contains the scripts and tools used for finding vulnerabilities in the [Tenda CP3 IP Camera](https://github.com/SECloudUNIMORE/ACES/tree/master/Tenda). The paper discussing the whole process used for the identification of the vulnerabilities is accepted for publication at [IWSEC 2024 - International Workshop on Security 2024](https://www.iwsec.org/2024/index.html), and is currently available as preprint on [arXiv](https://arxiv.org/abs/2406.15103).

## Content
This repo includes two major scripts:
  - `rootfs_extractor.sh`: a bash script used to extract the different partitions from the flash image;
  - `call_tree.py`: a Ghidra plugin that constructs a tree of function invocations from the main including only branches that contains one of the interesting functions (the `TARGET` list of the script)


## Credits
If you use any part of this repository, you are kindly invited to cite our work: 
```
@misc{stabili2024findingandexploitingvulnerabilities,
      title={Finding (and exploiting) vulnerabilities on IP Cameras: the Tenda CP3 case study}, 
      author={Dario Stabili and Tobia Bocchi and Filip Valgimigli and Mirco Marchetti},
      year={2024},
      eprint={2406.15103},
      archivePrefix={arXiv},
      primaryClass={cs.CR}
      url={https://arxiv.org/abs/2406.15103}, 
}

```