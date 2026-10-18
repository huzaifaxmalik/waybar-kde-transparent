#!/usr/bin/env bash
# find the right qdbus binary
Q=$(command -v qdbus6 || command -v qdbus-qt6 || command -v qdbus)
