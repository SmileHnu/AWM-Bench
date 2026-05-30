# Towards Acoustic World Models: Benchmarking Physics-Grounded Reasoning in Audio-Language Models (AWM-Bench)

[![Paper](https://img.shields.io/badge/arXiv-Paper-red.svg)](INSERT_ARXIV_LINK_HERE)
[![Dataset](https://img.shields.io/badge/%F0%9F%A5%97-Hugging%20Face-yellow)](INSERT_HF_LINK_HERE)
[![License: CC-BY-4.0](https://img.shields.io/badge/License-CC--BY--4.0-lightgrey.svg)](https://creativecommons.org/licenses/by/4.0/)

This repository contains the official dataset, prompts, and evaluation scripts for **AWM-Bench**, a benchmark designed to evaluate physics-grounded reasoning in Audio-Language Models (ALMs).

---

## 📌 Overview

While current Audio-Language Models (ALMs) excel at semantic audio recognition and captioning, it remains unclear whether they understand sound as a physical process. **AWM-Bench** evaluates ALMs across three causal stages of acoustics:

1. **Generation**: Inferring source materials, surface properties, excitation mechanisms, and fluid motion.
2. **Propagation**: Reasoning about spatial localization, distance, motion, transmission paths, and echoes.
3. **Perception**: Predicting human auditory outcomes such as audibility, masking, and perceived loudness.

Unlike existing semantic benchmarks, AWM-Bench consists of **13 tasks** specifically designed to reduce reliance on linguistic shortcuts, forcing models to rely on physical cues like frequency, amplitude, phase, and spatial differences.

<p align="center">
  <img src="docs/overview.png" alt="AWM-Bench Overview" width="80%">
</p>

---

## 📊 Task Taxonomy & Dataset Statistics

AWM-Bench contains **2,110 samples** (totaling 6.36 hours of audio) compiled from public datasets, controlled recordings, and physical synthesis:

| Stage | Task | Shorthand | Source Type | # Samples | Avg. Duration (s) |
| :--- | :--- | :---: | :---: | :---: | :---: |
| **Generation** | Material Property Inference | $T_{MPI}$ | Great Hits | 510 | 5.39 |
| | Surface Property Inference | $T_{SPI}$ | Great Hits | | |
| | Excitation Mechanism Recognition | $T_{EMR}$ | Great Hits / Rec | | |
| | Fluid Motion Recognition | $T_{FMR}$ | ESC-50 | | |
| **Propagation** | Sound Source Localization | $T_{SSL}$ | Controlled Rec. | 1,100 | 16.04 |
| | Distance Estimation | $T_{DE}$ | Controlled Rec. | | |
| | Source Motion Inference | $T_{SMI}$ | Controlled Rec. | | |
| | Propagation Path Inference | $T_{PPI}$ | Controlled Rec. | | |
| | Echo Detection | $T_{ED}$ | Synthetic | | |
| | Acoustic Environment Inference | $T_{AEI}$ | TUT Scenes | | |
| **Perception** | Audibility Detection | $T_{AD}$ | Synthetic | 500 | 5.00 |
| | Masking Discrimination | $T_{MD}$ | Synthetic | | |
| | Loudness Perception Inference | $T_{LPI}$ | Synthetic | | |
| **Total** | | | | **2,110** | **10.85** |
