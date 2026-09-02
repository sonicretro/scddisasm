using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Drawing;
using SonicRetro.SonLVL.API;
using SonicRetro.SonLVL.API.SCD;

namespace SCDObjectDefinitions.Common
{
	public class MonitorTime : ObjectDefinition
	{
		private struct MonitorTimeData
		{
			public string name;
			public Sprite sprite_low;
			public Sprite sprite_high;

			public MonitorTimeData(string name, int frame, byte[] art_file)
			{
				this.name = name;
				this.sprite_low = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/monitor_time.asm", frame, 0, false);
				this.sprite_high = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/monitor_time.asm", frame, 0, true);
			}
		}

		private Sprite img;
		private MonitorTimeData[] monitors;

		public override void Init(ObjectData data)
		{
			byte[] art_file = ObjectHelper.OpenArtFile("../src/gfx/monitor_time.nem", CompressionType.Nemesis);
			img = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/monitor_time.asm", 8, 0);

			monitors = new MonitorTimeData[10];
			monitors[0] = new MonitorTimeData(
				"1-UP", 0, art_file
			);
			monitors[1] = new MonitorTimeData(
				"Rings", 1, art_file
			);
			monitors[2] = new MonitorTimeData(
				"Shield", 2, art_file
			);
			monitors[3] = new MonitorTimeData(
				"Invincibility", 3, art_file
			);
			monitors[4] = new MonitorTimeData(
				"Speed Shoes", 4, art_file
			);
			monitors[5] = new MonitorTimeData(
				"Stopwatch", 5, art_file
			);
			monitors[6] = new MonitorTimeData(
				"Combine Ring", 6, art_file
			);
			monitors[7] = new MonitorTimeData(
				"S", 7, art_file
			);
			monitors[8] = new MonitorTimeData(
				"Past Time Post", 10, art_file
			);
			monitors[9] = new MonitorTimeData(
				"Future Time Post", 12, art_file
			);
		}

		public override ReadOnlyCollection<byte> Subtypes
		{
			get { return new ReadOnlyCollection<byte>(new byte[] { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 }); }
		}

		public override string Name
		{
			get { return "Monitor/Time Post"; }
		}

		public override bool RememberState
		{
			get { return true; }
		}

		public override string SubtypeName(byte subtype)
		{
			if (subtype < monitors.Length)
				return monitors[subtype].name;
			return string.Empty;
		}

		public override Sprite Image
		{
			get { return img; }
		}

		public override Sprite SubtypeImage(byte subtype)
		{
			if (subtype < monitors.Length)
				return monitors[subtype].sprite_low;
			return ObjectHelper.UnknownObject;
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			if (LevelData.Level.Zone == 6 && ((SCDObjectEntry)obj).SubType2 == 0)
			{
				if (obj.SubType < monitors.Length)
					return new Sprite(monitors[obj.SubType].sprite_high, obj.XFlip, obj.YFlip);
				return ObjectHelper.UnknownObject;
			}
			return new Sprite(SubtypeImage(obj.SubType), obj.XFlip, obj.YFlip);
		}
		
		public override int GetDepth(ObjectEntry obj)
		{
			if (LevelData.Level.Zone == 6 && ((SCDObjectEntry)obj).SubType2 == 0)
				return 0;
			return 4;
		}

		private PropertySpec[] custom_properties = new PropertySpec[] {
			new PropertySpec("Back Layer", typeof(bool), "Extended", "If true, the monitor/time post is placed on the back layer (Metallic Madness only).", null,
				(obj) => { return (((SCDObjectEntry)obj).SubType2 & 1) == 1; },
				(obj, value) => ((SCDObjectEntry)obj).SubType2 = (byte)((((SCDObjectEntry)obj).SubType2 & ~1) | ((bool)value ? 1 : 0)))
		};

		public override PropertySpec[] CustomProperties
		{
			get { return custom_properties; }
		}
	}
}
