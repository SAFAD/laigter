#ifndef LIGHTSOURCE_H
#define LIGHTSOURCE_H

#include <QColor>
#include <QObject>
#include <QVector3D>

struct LightSettings {
  QColor diffuseColor, specularColor;
  float diffuseIntensity, specularIntensity, specularScatter;
  QVector3D lightPosition;
};

class LightSource : public QObject {
  Q_OBJECT
public:
  explicit LightSource(QObject *parent = nullptr);

signals:

public slots:
  void set_diffuse_color(QColor color);
  QColor get_diffuse_color();
  void set_diffuse_intensity(float intensity);
  float get_diffuse_intensity();

  void set_height(float height);
  float get_height();

  void set_specular_color(QColor color);
  QColor get_specular_color();
  void set_specular_intensity(float intensity);
  float get_specular_intesity();
  void set_specular_scatter(float scatter);
  float get_specular_scatter();

  void set_light_position(QVector3D position);
  QVector3D get_light_position();

  void copy_settings(LightSource *l);

private:
  int id;
  bool selected;
  LightSettings settings;
};

#endif // LIGHTSOURCE_H
